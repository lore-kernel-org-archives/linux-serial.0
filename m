From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v4 1/2] serial_core: add pci uart early console support
Date: Wed, 27 May 2015 16:18:16 -0700
Message-ID: <20150527231816.GB105692@worksta>
References: <20150522160659.GA108447@worksta>
 <20150524195225.GA20120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150524195225.GA20120@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On Sun, May 24, 2015 at 12:52:25PM -0700, Greg Kroah-Hartman wrote:
> > Signed-off-by: Bin Gao <bin.gao@intel.com>
> > ---
> > Changes in v4:
> >  - moved PCI_EARLY definition from arch/x86/Kconfig to drivers/pci/Kconfig
> >  - added 'earlyprintk' for x86 as alias to the early param 'earlycon'
> 
> What about the changes in earlier versions?
> 
> And why do I have 3 copies of different "v4" patches in my inbox?
> 
> Please resend this, as v5, correctly, and we can review it that way.
> 
> greg k-h

Will address this altogether with comments from other reviewers in v5. Thanks.

-Bin
