from rembg import remove
from PIL import Image
import os
import sys
import argparse

def remove_background(input_path, output_path=None):
    """
    Remove the background from an image using machine learning.
    
    Args:
        input_path (str): Path to the input image
        output_path (str, optional): Path for the output image. If not provided,
                                   will use input filename with '_nobg' suffix
    
    Returns:
        str: Path to the output image
    """
    # Input validation
    if not os.path.exists(input_path):
        raise FileNotFoundError(f"Input image not found: {input_path}")
    
    # Generate output path if not provided
    if output_path is None:
        file_name, file_ext = os.path.splitext(input_path)
        output_path = f"{file_name}_nobg{file_ext}"
    
    try:
        # Open the input image
        input_image = Image.open(input_path)
        
        # Remove the background
        output_image = remove(input_image)
        
        # Save the result
        output_image.save(output_path, format='PNG')
        
        print(f"Background removed successfully. Saved to: {output_path}")
        return output_path
        
    except Exception as e:
        print(f"Error processing image: {str(e)}")
        raise

def main():
    # Set up command line argument parser
    parser = argparse.ArgumentParser(description='Remove background from images using ML')
    parser.add_argument('input_path', help='Path to the input image')
    parser.add_argument('--output', '-o', help='Path for the output image (optional)')
    
    args = parser.parse_args()
    
    try:
        remove_background(args.input_path, args.output)
    except Exception as e:
        print(f"Error: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()