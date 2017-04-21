From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Date: Fri, 21 Apr 2017 09:50:39 +0200
Message-ID: <f27afb36-f75c-0a03-dca2-8f318265f520@physik.fu-berlin.de>
References: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
 <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/21/2017 09:26 AM, Geert Uytterhoeven wrote:
> Does anyone have access to real hardware to try?
> Adrian: does it work on your LANDISK, which also has SH7751R?

I can give it a try but that will take a few days since I am currently
not at home where my LANDISK boxes are. I also had issues with the
IDE driver in the past but Sato-san gave me some tips regarding it.

However, Rich also has a LANDISK device that I donated for him, so if his
hardware is currently ready to use, he could give it a try.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
