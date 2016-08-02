From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0967/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 15:46:34 +0200
Message-ID: <20160802134634.GA26043@kroah.com>
References: <20160802120332.14527-1-baolex.ni@intel.com>
 <CAJs94EZmP3tcZAHa3MFypSHCdrv7pSJKY=ENibt9Tj3U33u+CA@mail.gmail.com>
 <CAJs94EZzq6+d1+ZLBKoEDfvxV=qbW++diQ=eqauOSY1VDkSH4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJs94EZzq6+d1+ZLBKoEDfvxV=qbW++diQ=eqauOSY1VDkSH4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Baole Ni <baolex.ni@intel.com>, Jiri Slaby <jslaby@suse.com>, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, Peter Hurley <peter@hurleysoftware.com>, yamada.masahiro@socionext.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, chuansheng.liu@intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 02, 2016 at 04:34:20PM +0300, Matwey V. Kornilov wrote:
> And actually S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH  can be simplified
> to S_IRUGO | S_IWUSR, not?
> I think we need to have and use dedicated special macros for most
> common magic octal permissions like 0755 or 0644.

We already do have them, the developer here decided to not use them for
some unknown reason, making all 1285 of these patches wrong :(
