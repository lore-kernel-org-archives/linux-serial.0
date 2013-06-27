From: Andreas Helmcke <ahe@helmcke.name>
Subject: usb_serial, ftdi_sio chars_in_buffer blocking tcdrain
Date: Thu, 27 Jun 2013 14:17:08 +0200
Message-ID: <51CC2D44.9090400@helmcke.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dd27114.kasserver.com ([85.13.133.83]:41323 "EHLO
	dd27114.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab3F0MXi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Jun 2013 08:23:38 -0400
Received: from [10.0.1.177] (mail.ela-soft.com [213.23.49.162])
	by dd27114.kasserver.com (Postfix) with ESMTPSA id EBE5B25C0102
	for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2013 14:17:08 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

after upgrading from Kernel 3.5 to Kernel 3.8 (actually updating kubuntu 12.10 to 13.04) I am having the problem, that
some times tcdrain does not return.

To be more precise:
I am having an application which polls some devices on a RS485-bus. It does this by sending 3 Bytes, calling tcdrain and
then waiting for the answer / timeout. This worked flawlessly on kernels up to 3.5. With kernel 3.8 regularly the
application hangs because tcdrain does not return.

dmesg-log with usbserial and ftdi_sio with debug on:

Jun 26 17:28:03 tupai kernel: [25094.164268] ftdi_sio ttyUSB0: ftdi_get_modem_status - 0x0260
Jun 26 17:28:03 tupai kernel: [25094.164274] ftdi_sio ttyUSB0: ftdi_chars_in_buffer - 0
Jun 26 17:28:03 tupai kernel: [25094.164280] tty ttyUSB0: serial_write_room - port 0
Jun 26 17:28:03 tupai kernel: [25094.164300] tty ttyUSB0: serial_write - port 0, 3 byte(s)
Jun 26 17:28:03 tupai kernel: [25094.164314] tty ttyUSB0: serial_chars_in_buffer - port 0
Jun 26 17:28:03 tupai kernel: [25094.164318] ftdi_sio ttyUSB0: ftdi_chars_in_buffer - 3
Jun 26 17:28:03 tupai kernel: [25094.164322] tty ttyUSB0: serial_chars_in_buffer - port 0
Jun 26 17:28:03 tupai kernel: [25094.164326] ftdi_sio ttyUSB0: ftdi_chars_in_buffer - 3
Jun 26 17:28:03 tupai kernel: [25094.164363] tty ttyUSB0: usb_serial_port_work - port 0
Jun 26 17:28:03 tupai kernel: [25094.164384] tty ttyUSB0: serial_chars_in_buffer - port 0
Jun 26 17:28:03 tupai kernel: [25094.164535] ftdi_sio ttyUSB0: ftdi_get_modem_status - 0x0200
Jun 26 17:28:03 tupai kernel: [25094.164541] ftdi_sio ttyUSB0: ftdi_chars_in_buffer - 1

--> Application blocks (tcdrain does not return).

My guess is, that the waitqueue which is used in the call to wait_event_interruptible_timeout in the function
tty_wait_until_sent does not reliably get triggered, when the modem status changes the FTDI_RS_TEMT flag.

Is this a know bug? Is this already addressed by the changes which are discussed in the thread "Re: Regression: ftdi_sio
is slow (since Wed Oct 10 15:05:06 2012)" ?


   Andreas
