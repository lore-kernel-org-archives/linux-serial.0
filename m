From: Andrew Hogue <hogue@cs.yorku.ca>
Subject: Hanging on Reads
Date: Tue, 7 Oct 2003 11:37:47 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.56.0310071132270.12710@nemesis.cs.yorku.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns1.cs.yorku.ca ([130.63.92.20]:58301 "EHLO green.cs.yorku.ca")
	by vger.kernel.org with ESMTP id S261271AbTJGPhs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Oct 2003 11:37:48 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm currently experiencing a problem with my serial port code and was
hoping that someone has a solution to this problem.

Basically, I open the serial port, set the attributes, write to the device
and then since I expect a response, I call read(), but it seems to hang on
the read indefinitely.

The weird thing is that there is a workaround to this problem which makes
everything work, but it is ugly.

The workaround is to simply open() the serial port, close() the serial
port and then re-open it at the beginning of the program.

Here is a piece of my code,

/* stupid workaround here */
f = fopen(SERIALPORT, O_RDWR);
close(f);

f = fopen(SERIALPORT, O_RDWR);
...
	tcgetattr(f,&termold);
	term.c_cflag = B38400 | CS8 | CLOCAL | CREAD;
	term.c_iflag = 0;
	term.c_oflag = 0;
	term.c_lflag = 0;
	term.c_cc[VMIN] = 1;
	term.c_cc[VTIME] = 0;
	tcflush(f,TCIOFLUSH);
	tcsetattr(f,TCSANOW,&term);
	tcflush(f,TCIOFLUSH);
...
n = write(f,"R",1);
...
n = read(f,resp,1);
...

If I don't have the first 2 lines in this piece of code, it hangs on the
read, however if the first 2 lines exist, everything works fine.

What does this indicate?

What does the close() actually do to the file descriptor?

Is there a way to do the same thing but with an ioctl() ?

Thanks,

-- Andrew
