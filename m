From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
Date: Wed, 24 Apr 2019 11:58:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1904241157300.10713@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7h5zr9dcsi.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Atish Patra <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Kevin,

On Fri, 19 Apr 2019, Kevin Hilman wrote:
> Atish Patra <atish.patra@wdc.com> writes:
> > On 4/18/19 4:22 PM, Kevin Hilman wrote:
> >> Paul Walmsley <paul.walmsley@sifive.com> writes:
> >> 
> >>> This series adds a serial driver, with console support, for the
> >>> UART IP block present on the SiFive FU540 SoC.  The programming
> >>> model is straightforward, but unique.
> >>>
> >>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
> >>> open-source FSBL (with appropriate patches to the DT data).
> >>>
> >>> This fifth version fixes a bug in the set_termios handler,
> >>> found by Andreas Schwab <schwab@suse.de>.
> >>>
> >>> The patches in this series can also be found, with the PRCI patches,
> >>> DT patches, and DT prerequisite patch, at:
> >>>
> >>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4

...

> I've just updated to u-boot master branch with SMP enabled, and build a
> new openSBI (also from master branch) with u-boot payload. Using your
> v5.1-rc4_unleashed branch, I see 4 CPUs booting:
> https://termbin.com/kg13

Now that the serial driver is working for you, care to send a Tested-by: ?


thanks,

- Paul
