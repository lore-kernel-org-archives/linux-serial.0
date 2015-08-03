From: Adam Lee <adam.lee@canonical.com>
Subject: Re: [PATCH 1/2] pci_ids: Add Pericom vendor and device ids
Date: Mon, 3 Aug 2015 12:44:28 +0800
Message-ID: <20150803044428.GD19820@adam-laptop>
References: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
 <20150803043647.GA20605@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150803043647.GA20605@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Aug 02, 2015 at 09:36:47PM -0700, Greg Kroah-Hartman wrote:
> On Mon, Aug 03, 2015 at 12:33:20PM +0800, Adam Lee wrote:
> > This patch add Pericom's vendor id and Pericom PI7C9X795[1248] chips'
> > device ids.
> > 
> > Signed-off-by: Adam Lee <adam.lee@canonical.com>
> > ---
> >  include/linux/pci_ids.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index fcff8f8..c4a93cf 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2995,4 +2995,10 @@
> >  
> >  #define PCI_VENDOR_ID_OCZ		0x1b85
> >  
> > +#define PCI_VENDOR_ID_PERICOM			0x12D8
> > +#define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
> > +#define PCI_DEVICE_ID_PERICOM_PI7C9X7952	0x7952
> > +#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
> > +#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
> 
> Please read the top of this file, this isn't needed...
> 
> thanks,
> 
> greg k-h

Oops. Pericom also has other products than serial card, so is it OK if I
still leave PCI_VENDOR_ID_PERICOM in pci_ids.h and move device ids to
particular driver? Thanks.

-- 
Adam Lee
