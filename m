From: Karl Palsson <karlp-PhA6lrgffZtPR4JQBCEnsQ@public.gmane.org>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Mon, 14 Apr 2014 10:13:20 +0000
Message-ID: <20140414101320.GA19305@palmtree.beeroclock.net>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com>
 <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kijam =?iso-8859-1?Q?L=F3pez?= <kijamve-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On Sun, Apr 13, 2014 at 08:51:56PM -0430, Kijam L=F3pez wrote:
> The following code works for me correctly in Windows, but Linux does
> not work. I am using the same PC, both operating systems are installe=
d
> native. I do not use virtual machine. I need to work on Linux. I have
> tried in different linux distributions and does not work anywhere.
[snip]
>       if(!serial.setParity(QSerialPort::EvenParity))
>             qCritical()<<"Error in setParity";

the ch34x driver does not (yet) support parities other than None.  It d=
oesn't report a
failure though, it just simply ignores it altogether.

If you're actually working with an even parity device, you're going to =
have all sorts of
not-fun.  I've got a patch here: http://www.spinics.net/lists/linux-usb=
/msg105238.html
but I've not (yet) resubmitted it after Johan Hovold's comments

Cheers,
Karl P
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
