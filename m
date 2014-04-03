From: "Valerio Vanni" <valerio.vanni@inwind.it>
Subject: Re: serial console does not wake from S3 suspend
Date: Thu, 3 Apr 2014 15:10:52 +0200
Message-ID: <DCDB9C58604645E6A841B7977A1BF0C1@vanni.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

"Valerio Vanni" <valerio@valeriovanni.com> ha scritto nel messaggio
news:lg9etc$9fl$1@ger.gmane.org
> When resuming from S3 suspend, serial console starts sending garbage
> on the serial port.
> Not continuously, it sends garbage only when in local console prints a
> text.
> It stops only when the (sending) machine is shut down, or if some
> text is sent manually (i.e. with "cat txtfile > /dev/ttyS0").
>
> Full details are here:
> https://bugzilla.kernel.org/show_bug.cgi?id=69751

The problem is still present in final 3.14 (and in linux-next).
