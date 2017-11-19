From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: 8250_pci: Add Amazon PCI serial device ID
Date: Sun, 19 Nov 2017 09:41:21 +0100
Message-ID: <20171119084121.GB15844@kroah.com>
References: <20171113083111.GB22719@kroah.com>
 <1510601491-31803-1-git-send-email-msw@linux.com>
 <20171119042607.GA26232@ued668862963453.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171119042607.GA26232@ued668862963453.ant.amazon.com>
Sender: stable-owner@vger.kernel.org
To: Matt Wilson <msw@amzn.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Nov 18, 2017 at 08:26:07PM -0800, Matt Wilson wrote:
> On Mon, Nov 13, 2017 at 11:31:31AM -0800, Matt Wilson wrote:
> > From: Matt Wilson <msw@amazon.com>
> > 
> > This device will be used in future Amazon EC2 instances as the primary
> > serial port (i.e., data sent to this port will be available via the
> > GetConsoleOuput [1] EC2 API).
> 
> Ping?

Middle of the merge window, can't do anything until 4.15-rc1 is out,
please be patient...

greg k-h
