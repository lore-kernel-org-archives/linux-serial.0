From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v3 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
Date: Thu, 11 Apr 2019 01:54:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com>
References: <20181020101045.15991-1-paul.walmsley@sifive.com> <mvmr2bkxntv.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmr2bkxntv.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 6 Mar 2019, Andreas Schwab wrote:

> Trying to log in on the serial console causes the system to freeze.  The
> last message is:
> 
> [  115.597858] sifive-serial 10010000.serial: BRKINT/PARMRK flag not supported

Have not seen that problem.

If you're still seeing this, could you follow up with me off-list so we 
can synchronize configurations, both with the kernel and with non-kernel 
boot & M-mode components?


- Paul
