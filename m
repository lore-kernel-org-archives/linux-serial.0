From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Sun, 13 Apr 2014 18:44:10 -0700
Message-ID: <20140414014410.GA5136@kroah.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com>
 <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42508 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbaDNBlO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Apr 2014 21:41:14 -0400
Content-Disposition: inline
In-Reply-To: <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kijam =?iso-8859-1?Q?L=F3pez?= <kijamve@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Apr 13, 2014 at 08:51:56PM -0430, Kijam L=F3pez wrote:
> The following code works for me correctly in Windows, but Linux does
> not work. I am using the same PC, both operating systems are installe=
d
> native. I do not use virtual machine. I need to work on Linux. I have
> tried in different linux distributions and does not work anywhere.

<snip>

Sounds like a Qt issue, what is the status of the bug you filed with
those developers?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
