From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 05:33:53 -0400
Message-ID: <87A6509B-3297-44A1-B1E4-24AA7DAEFB43@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk> <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com> <20160820142226.6121e76d@lxorguk.ukuu.org.uk> <CC150758-1D16-4BB7-A35B-1A7F4D061C7C@goldelico.com> <20160821180910.51cf919d@lxorguk.ukuu.org.uk> <FF7761E8-377A-43AD-96B2-83BA140E030B@goldelico.com> <20160822100936.19fd809f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160822100936.19fd809f-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

>>> We do, today for bluetooth and other protocols just fine  
>> I think it works (even with user-space HCI daemon) because bluetooth HCI is slow (<300kByte/s).
> 
> We do it for PPP over 3G modem as well. Modern 3G modems pretend to be
> network devices, older ones didn't - and you are correct that in that
> scenario we struggled (it's a lot better since Peter sorted the locking
> out to be efficient).

you have this backwards. Older 3G modems pretended to by Hayes compatible and pretended to be talking PPP. However PPP is terminated in the modem itself. It is not spoken over the 3GPP networks. These are purely IP.

And yes, in theory there was a dialup in GSM, but I don't know of any users. Even early 9600 baud communication was RLP based. And for modern things like LTE it is IP all the way (including voice).

What some modems still do today is pretend they are Ethernet devices. That is faked by the modem as well and mainly for some odd Windows crap. However many modern modems give you the raw IP stream. You just have to ask nicely.

Regards

Marcel
