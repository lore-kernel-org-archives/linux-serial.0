From: "Eric C. Gallimore" <egallimore@whoi.edu>
Subject: Difficulty with SIGHUP
Date: Tue, 26 Apr 2011 12:24:24 -0400
Message-ID: <8401AB0ED9B5844D886C30A11EEBAD7D01D12937A5C9@app1.aherncopy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.aherncopy.com ([96.57.150.90]:34625 "EHLO
	mail.aherncopy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1DZQ3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Apr 2011 12:29:53 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi,

I'm running an embedded system with a modem attached to a serial port (using the sc16is7x2 driver), and it seems that SIGHUP is not generated when the DCD line is dropped.

I've verified that clocal is disabled and that the state of the DCD line is properly reported by termios (I'm using 'show comm' in Kermit, since it's easy.)

However, if I attach a shell to the serial port (mgetty spawning login spawning bash), it doesn't hang up when the DCD line goes low.  If I send a SIGHUP to the bash or login process via 'kill -HUP', it hangs up.

Any ideas?

Thanks in advance,

Eric


Eric Gallimore
Acoustic Communications Group
Woods Hole Oceanographic Institution

