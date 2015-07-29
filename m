From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH V2 1/1] serial: 8250_pci: add RS485 for F81504/508/512
Date: Wed, 29 Jul 2015 14:01:08 +0200
Message-ID: <20150729140108.30120282@north>
References: <1438055964-9310-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438055964-9310-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 28 Jul 2015 11:59:24 +0800, Peter Hung wrote:
> Add RS485 control for Fintek F81504/508/512
> 
> F81504/508/512 can control their RTS with H/W mode.
> PCI configuration space for each port is 0x40 + idx * 8 + 7.
> 
> When it set with 0x01, it's configured with RS232 mode.
> RTS is controlled by MCR.
> 
> When it set with 0x11, it's configured with RS485 mode.
> RTS is controlled by H/W, RTS low with idle & RX, high with TX.
> 
> When it set with 0x31, it's configured with RS485 mode.
> RTS is controlled by H/W, RTS high with idle & RX, low with TX.
> 
> We will force 0x01 on pci_fintek_setup().
> 
> Changelog:
> V2
> 1. change direct bit operation with meaningful define name.
> 2. due to F81504 series only support SER_RS485_ENABLED &
>    SER_RS485_RTS_ON_SEND. We'll clean non-support area of
>    struct serial_rs485.
> 3. change control method of SER_RS485_RTS_ON_SEND. In our
>    reference circuit, the transceiver default mode needed
>    in rx mode with RTS logic high, tx mode with RTS logic low.
> 
>    If user set to SER_RS485_ENABLED(default), we should set
>    reg with 0x31. if SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND
>    will set reg to 0x11.
> 
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>

Looks better, thanks.  For future postings please put the changelog
below the ---, we don't need it in the logs.
