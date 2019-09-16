From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 03:21:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909160320540.9917@viisi.sifive.com>
References: <20190910055923.28384-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190910055923.28384-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 10 Sep 2019, Christoph Hellwig wrote:

> The sifive serial driver implements earlycon support, but unless
> another driver is built in that supports earlycon support it won't
> be usable.  Explicitly select SERIAL_EARLYCON instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul
