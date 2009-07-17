From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [RFC] tty (or char) bus?
Date: Fri, 17 Jul 2009 13:54:28 -0400
Message-ID: <20090717175428.GB4852@const.linuxsymposium.org>
References: <4A5CA4CB.8070500@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965021AbZGQRye@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A5CA4CB.8070500@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-serial@vger.kernel.org

Hello,

Janusz Krzysztofik, le Tue 14 Jul 2009 17:31:23 +0200, a =E9crit :
> In my attempt to add support for contols to a voice modem codec sound=
=20
> device driver, I found that in order to talk to the modem, it would b=
e=20
> convenient if I can get access to a tty device from inside the kernel=
 in=20
> a way similiar to that available form userspace.

I agree.

> AFAICS, even if tty lowlevel write() could be used unmodified, a
> convenient way of reading characters from a tty is missing and should
> be implemented in a line discipline. Please correct me if I am wrong.

Have you seen the receive_buf line discipline hook?  Indeed it's not a
read() operation as from userland, but at least you can get the data
from the tty that way.

> OTOH, I found that some kind of abstraction layer for acccessing devi=
ces=20
> over a tty could be convenient. Instead of allocating a new line=20
> discipline for each specific device, sometimes found on a specific bo=
ard=20
> only, why not just create a new bus type?

I'd tend to agree with you, as I also have a use case for that: braille
& speech synthesis devices.  However for now I haven't found a really
convincing argument why line disciplines aren't enough.

Samuel
