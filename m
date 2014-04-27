From: Chris <mailingliste.chris@gmail.com>
Subject: mxs-auart stop bit-RTS delay
Date: Sun, 27 Apr 2014 11:28:37 +0200
Message-ID: <535CCDC5.8000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f66.google.com ([74.125.83.66]:34933 "EHLO
	mail-ee0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbaD0J2j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Apr 2014 05:28:39 -0400
Received: by mail-ee0-f66.google.com with SMTP id b57so3278671eek.9
        for <linux-serial@vger.kernel.org>; Sun, 27 Apr 2014 02:28:38 -0700 (PDT)
Received: from ?IPv6:2a02:810a:580:348:ac36:9a12:3c37:dabd? ([2a02:810a:580:348:ac36:9a12:3c37:dabd])
        by mx.google.com with ESMTPSA id o4sm40249403eef.20.2014.04.27.02.28.36
        for <linux-serial@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 02:28:37 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I want to use the AUART0 of the i.MX28 with the handshake signals. For 
this I am using the latest stable Linux Kernel 3.14.1.

The AUART0 part of the device tree:

	auart0: serial@8006a000 {
    	pinctrl-names = "default";
    	pinctrl-0 = <&auart0_pins_a>; //four pins RX,TX,CTS,RTS
    	fsl,uart-has-rtscts;
    	status = "okay";
     };

So the device tree uses all four pins of this UART. In Linux itself I 
configure the interface with:

stty -F /dev/ttyAPP0 raw 9600 -echo -echoe -echok -echoctl -echoke crtscts

The UART and the handshake signals are working in principle. But I've 
noticed a delay between the RTS signal and the stopbit as you can see in 
the attached figure. If I have understood the RTS/CTS system correctly 
the RTS signal should be toggled immediately after the stopbit is sent. 
So that 13 ms (from the logic analyzer image) are really unnecessary and 
I can not trace it back where they are from. With other baudrates it is 
no less and no more than the 13 ms (~2...18ms-spread inside of the same 
baudrate)

I tried this too:

stty -F /dev/ttyAPP0 raw 9600 -echo -echoe -echok -echoctl -echoke -crtscts

The bits CTSEN and RTSEN of the UARTAPP_CTRL2 register are toggled, but 
there is still a something similar on the RTS lines, but now it is no 
CTS needed.

So my questions are, where are this delays come from?

How can I be sure who is toggling the RTS line (Linux or the i.MX28 
hardware module) ?

image logic analyzer:
https://community.freescale.com/servlet/JiveServlet/download/398158-274040/auart0_rts.png
