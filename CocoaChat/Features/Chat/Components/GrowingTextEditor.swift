import SwiftUI
import UIKit

struct GrowingTextEditor: UIViewRepresentable {
    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    @FocusState.Binding var isFocused: Bool

    let minHeight: CGFloat
    let maxHeight: CGFloat
    let textColor: UIColor
    let font: UIFont

    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            dynamicHeight: $dynamicHeight,
            isFocused: _isFocused,
            minHeight: minHeight,
            maxHeight: maxHeight
        )
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.textColor = textColor
        textView.font = font
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 2, bottom: 8, right: 2)
        textView.textContainer.lineFragmentPadding = 0
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
        }

        if isFocused, textView.window != nil, !textView.isFirstResponder {
            textView.becomeFirstResponder()
        }

        context.coordinator.recalculateHeight(for: textView)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        @Binding private var text: String
        @Binding private var dynamicHeight: CGFloat
        @FocusState.Binding private var isFocused: Bool

        private let minHeight: CGFloat
        private let maxHeight: CGFloat

        init(
            text: Binding<String>,
            dynamicHeight: Binding<CGFloat>,
            isFocused: FocusState<Bool>.Binding,
            minHeight: CGFloat,
            maxHeight: CGFloat
        ) {
            _text = text
            _dynamicHeight = dynamicHeight
            _isFocused = isFocused
            self.minHeight = minHeight
            self.maxHeight = maxHeight
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
            recalculateHeight(for: textView)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            isFocused = true
        }

        func recalculateHeight(for textView: UITextView) {
            let fittingSize = CGSize(width: textView.bounds.width, height: .greatestFiniteMagnitude)
            let size = textView.sizeThatFits(fittingSize)
            dynamicHeight = min(max(minHeight, size.height), maxHeight)
            textView.isScrollEnabled = size.height > maxHeight
        }
    }
}
