From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: gpio-exar: Why filtering out Commtech devices?
Date: Tue, 23 May 2017 23:16:42 +0200
Message-ID: <e541be56-c61c-358b-91ed-ce1e513c1ccc@siemens.com>
References: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
 <7a25751e-931f-b713-dcdd-7a7483aae115@codethink.co.uk>
 <c7b03839-c2ab-fa3e-3af6-5d4678fa3bbd@siemens.com>
 <fc74be3d-7f74-cec3-769e-5eb53b2556b3@siemens.com>
 <CAPpjZG9MGDzS0Bu2c6M-Pob5JkzeAptDu8QNnDJETinCenee0w@mail.gmail.com>
 <b725379e-fc67-d706-e172-ca585c3f5e3d@siemens.com>
 <6ac3fff4-5d23-d30c-1e04-e5a1f12f466d@siemens.com>
 <CAPpjZG_HPFqKzf+7rBxM27TJcZJ4+vfUYSPChifM-JTN7ekTOA@mail.gmail.com>
 <2445db07-a150-e954-099c-f39faefeb4b5@siemens.com>
 <CAPpjZG953JHZWt8UzgEmYurSMh9o1v5HvxmO+4FD41M92GA-Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPpjZG953JHZWt8UzgEmYurSMh9o1v5HvxmO+4FD41M92GA-Ww@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Technical Support <techsupport@commtech-fastcom.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-05-23 22:05, Technical Support wrote:
> ​Our kernel module handles card specific MPIO setup, ensuring the pins
> are set correctly for our hardware regardless of what exar_8250
> initializes them as.   
> 
> https://github.com/commtech/serialfc-linux/blob/784e1321e00d4f72c93dae8da11cdc7f99c15dee/src/utils.c#L1463-L1491

OK, that code shows what we need to do in the official driver: handle
the commtech devices like before, i.e. keep the GPIOs as output for
them. I'll update my patch.


But now some good advice: you should rather work on the upstream code
and schedule your special driver for retirement. This will ensure that
your users have the best experience when they plug in any of your cards
and boot a standard Linux disto: it will just work.

Right now, your out-of-tree driver competes with the official one for
the same resources, apparently comes with own userspace interfaces to
configure special features instead of building on existing APIs (you
don't support TIOCSRS485 e.g., do you?), and seems to contain support
for a number of cards that are still missing in upstream. This is very
unhandy for your users.

For the same reason, we are currently upstreaming the code for our
Exar-based design (and that's why I came across all this): We want to
get rid of special board support to improve user experience and
long-term availability.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
