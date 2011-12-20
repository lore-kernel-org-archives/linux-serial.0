From: Subodh Nijsure <nijsure.subodh@gmail.com>
Subject: Connecting serial ports back to back.
Date: Mon, 19 Dec 2011 16:15:43 -0800
Message-ID: <CAMFeL9JMTo_ms6TUVeA3imqB0iymPONOGk=hBPmmGM2gY1ZArg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35764 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1LTAPo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Dec 2011 19:15:44 -0500
Received: by iaeh11 with SMTP id h11so9316024iae.19
        for <linux-serial@vger.kernel.org>; Mon, 19 Dec 2011 16:15:43 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have hardware where we have two ports that need to be connected back
to back.  One serial port is /dev/ttyAPP2 and other is /dev/ttyUSB0

Basically what I want to make happen is data coming from /dev/ttyUSB0
should be sent to /dev/ttyAPP2 and vice versa.

It appears that I should be able to do this using the n_tracesink and
n_tracerouter line discipline drivers.

Has anyone been successful in hooking up serial ports back-to-back
using these two line discipline drivers?

/Subodh
