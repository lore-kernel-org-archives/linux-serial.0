From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Date: Wed, 23 Jan 2019 16:11:06 +0200
Message-ID: <20190123141106.GG9224@smile.fi.intel.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
 <20190122115508.GB22960@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122115508.GB22960@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guan Yung Tseng <guan.yung.tseng@ni.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 22, 2019 at 01:55:08PM +0200, Heikki Krogerus wrote:
> On Mon, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
> > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > The reason of doing this is because all NI multi port serial cards
> > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > serial_pci_is_class_communication test added in the commit 7d8905d06405
> > ("serial: 8250_pci: Enable device after we check black list").
> 
> OK, so commit 7d8905d06405 ("serial: 8250_pci: Enable device after we
> check black list") has created a regression. If the device does not
> use PCI_CLASS_COMMUNICATION*SERIAL class, probe will fail, and I
> don't think that is how the driver should function.
> 
> If the device id is listed in serial_pci_tbl, we need to probe the
> device, regardless of the class id.

I need to check what should be a better fix.

> This is only working around the regression that 7d8905d064058 created,
> and only with your UART. There may be others.
> 
> We need to fix the regression, not work around it. How about something
> like the attached diff?

-- 
With Best Regards,
Andy Shevchenko
