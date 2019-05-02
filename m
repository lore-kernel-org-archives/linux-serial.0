From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Thu, 02 May 2019 11:57:18 -0700
Message-ID: <7hsgtwlm5t.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com> <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Atish Patra <atish.patra@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> On Fri, 19 Apr 2019, Kevin Hilman wrote:
>
>> Looks like Paul has so far only tested this with BBL + FSBL, so I think
>> I'll wait to hear from him how that setup might be different from using
>> OpenSBI + u-boot.
>
> I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> That's the traditional way of booting RISC-V Linux systems.

OK, but as you know, not the tradiaional way of booting most other linux
systems.  ;)

I'm working on getting RISC-V supported in kernelCI in a fully-automated
way, and I don't currently have the time to add add support for BBL+FSBL
to kernelCI automation tooling, so having u-boot support is the best way
to get support in kernelCI, IMO.

Kevin
