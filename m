From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] 8250_lpss: check null return when calling
 pci_ioremap_bar
Date: Sat, 7 Sep 2019 19:16:07 +0300
Message-ID: <20190907161607.GK2680@smile.fi.intel.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
 <20190726195345.30294-1-navid.emamdoost@gmail.com>
 <CAEkB2ERhxLj7ogoy1E3j8d4MyEZqroWS1tPRxyJXR2oLhNz+LQ@mail.gmail.com>
 <20190907155342.GG2680@smile.fi.intel.com>
 <CAEkB2ET-SQFiBbroxDFEVrPxto6a2wLJf0NM7R=ERcPargr66Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEkB2ET-SQFiBbroxDFEVrPxto6a2wLJf0NM7R=ERcPargr66Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: Navid Emamdoost <emamd001@umn.edu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 07, 2019 at 11:06:29AM -0500, Navid Emamdoost wrote:
> Cool! I thought it is forgotten, as there were no response to the v3 of the
> patch.

Nevertheless, you may send a follow up, since one call to pci_iounmap() is
missed when dw_dma_probe() fails.

> Thanks for letting me know.

You're welcome.

-- 
With Best Regards,
Andy Shevchenko
