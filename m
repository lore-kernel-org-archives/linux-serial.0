From: "Dale Whitchurch" <DaleW@sealevel.com>
Subject: Hdlc, Wan, and the like
Date: Mon, 24 Nov 2003 09:07:45 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <B39AA5DB06510C4591C6EDDD580B0B8161338F@mail.int.sealevel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [206.74.63.254] ([206.74.63.254]:55766 "EHLO
	mail.int.sealevel.com") by vger.kernel.org with ESMTP
	id S263439AbTKXOEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2003 09:04:52 -0500
content-class: urn:content-classes:message
List-Id: linux-serial@vger.kernel.org
To: Linux Net <linux-net@vger.kernel.org>, linux-serial@vger.kernel.org
Cc: Dale Whitchurch <DaleW@sealevel.com>

Hello all,

I wanted to spawn some discussion on the WAN/Serial interfaces supported
and their implemented protocols.

Specifically, I noticed support for some of the classic cards in our
line (net/wan/sealevel.c), and I am looking to help support all of our
cards.  But, I recently received a request for support of our card as a
character device rather than a networking device.

My questions are:  

1) Is there a reason to maintain these cards as network devices and
_not_ develop them as character devices as well?

2) Are there drivers or utilities already created that provide a
user-/kernel- level translation between a character device and a network
device?

3) As far as protocols go, is there any movement to create a standard
API for protocols, does one exist, and how well documented and tested is
it?

4) Any other logistics and/or options that I cannot think of right now
on this rainy Monday?

These questions are really in response to the main kernel thread and how
vendors are not supporting their cards.  I am trying to do my part in
making our cards supported in the happy place known as Linux.  And it
will be even better if I can help the development of the kernel along.

Thanks,

DaleW
