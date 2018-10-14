package manager;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/*
 * @author mkyong
 *
 */
public class ImageResize {
	public static String resize(String imgSrc, int rate) { // rate : 사이즈 비율
		int width = 0;
		int height = 0;
		String newName = "";
		
		try {
			System.out.println(imgSrc);
			BufferedImage originalImage = ImageIO.read(new File(imgSrc));
			System.out.println(originalImage.getWidth());
			System.out.println(originalImage.getHeight());
			width =(int) (originalImage.getWidth() * rate/100.0);
			height =(int) (originalImage.getHeight() * rate/100.0);
			
			int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
			
			String front = imgSrc.substring(0,imgSrc.lastIndexOf("."));
			String rear =  imgSrc.substring(imgSrc.lastIndexOf("."));
			
			newName = front + "_" + width + "_" +  height +  rear;
			if(!new File(newName).exists()) {			
				BufferedImage resizeImage = resizeImage(originalImage, type, width, height);
				ImageIO.write(resizeImage, rear.substring(1), new File(newName));
			}

		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		return newName;
	}

	private static BufferedImage resizeImage(BufferedImage originalImage, int type,int width,int height) {
		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, width, height, null);
		g.dispose();

		return resizedImage;
	}
}