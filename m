From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] 8250_pci.c: Update NI specific devices class to multi
 serial
Date: Tue, 15 Jan 2019 05:31:18 -0800
Message-ID: <20190115133118.GA31202@infradead.org>
References: <1547547005-2149-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547547005-2149-1-git-send-email-guan.yung.tseng@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 15, 2019 at 06:10:05PM +0800, Guan Yung Tseng wrote:
> +/*
> + * NI Serial devices incorrectly identify themselves
> + * PCI_CLASS_COMMUNICATION_OTHER, instead of what
> + * they really are: PCI_CLASS_COMMUNICATION_MULTISERIAL
> + */
> +static int pci_ni_probe(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
> +			(dev->class & 0xff);
> +	return 0;
> +}

This looks odd.  dev->class should just contain the class code read from
config space.  I think you need to work around this in the places that
check the classcode instead and add a quirk for these devices.
