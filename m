From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
Date: Fri, 19 Apr 2019 14:13:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7htvetbupi.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Atish Patra <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org


On Fri, 19 Apr 2019, Kevin Hilman wrote:

> Looks like Paul has so far only tested this with BBL + FSBL, so I think
> I'll wait to hear from him how that setup might be different from using
> OpenSBI + u-boot.

I'd recommend testing the DT patches with BBL and the open-source FSBL.  
That's the traditional way of booting RISC-V Linux systems.

The goal is to transition to U-Boot over time.  However, right now the 
U-boot port is still new.  It wouldn't surprise me if we need to modify 
the kernel, U-boot, or the SBI layers as part of that process.  In the 
short term, we need to get some sort of baseline DT data in place before 
more chips and boards start showing up.

I'll post a separate message with details on how to reproduce the test 
setup that I'm using.


- Paul
