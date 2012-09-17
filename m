From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: Linux USB Serial
Date: Mon, 17 Sep 2012 22:07:51 +0200
Message-ID: <87zk4o1kh4.fsf@nemi.mork.no>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:41502 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986Ab2IQUIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 16:08:15 -0400
In-Reply-To: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> (Steven
	J. Ackerman's message of "Mon, 17 Sep 2012 15:28:56 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Steven J. Ackerman" <steve@acscontrol.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

"Steven J. Ackerman" <steve@acscontrol.com> writes:

>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         2 Communications
>       bInterfaceSubClass     32=20

Looks like your bInterfaceSubClass is nibble swapped.  It should be 0x0=
2
for ACM, not 0x20.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
