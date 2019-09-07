From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] 8250_lpss: check null return when calling
 pci_ioremap_bar
Date: Sat, 7 Sep 2019 18:53:42 +0300
Message-ID: <20190907155342.GG2680@smile.fi.intel.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
 <20190726195345.30294-1-navid.emamdoost@gmail.com>
 <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: Navid Emamdoost <emamd001@umn.edu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 06, 2019 at 05:32:39PM -0500, Navid Emamdoost wrote:

> I was wondering is anyone reviewing this patch?
> https://lore.kernel.org/patchwork/patch/1106267/

Why?

The one below is a part of upstraem

commit f5d6aadf3b6434f11393e33be9fd25a56d0bc872
Author: Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri Jul 19 12:48:45 2019 -0500

    8250_lpss: check null return when calling pci_ioremap_bar

-- 
With Best Regards,
Andy Shevchenko
