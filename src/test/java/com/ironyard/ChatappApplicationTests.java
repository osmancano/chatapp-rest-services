package com.ironyard;

import com.ironyard.data.ChatPermissions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ChatappApplicationTests {

	@Test
	public void contextLoads() {
		ChatPermissions c = new ChatPermissions();
		c.setId(3l);
		c.setKey("hello");
		List tmp = new ArrayList();
		tmp.add(c);

		if (tmp.contains(new ChatPermissions("hello"))) {
			System.out.print("it works");
		}
	}

}
