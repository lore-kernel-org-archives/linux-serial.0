From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Fri, 26 Apr 2019 09:36:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1904260931310.28496@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <20190413020111.23400-2-paul.walmsley@sifive.com> <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-riscv@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@sifive.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 26 Apr 2019, Rob Herring wrote:

> On Fri, Apr 12, 2019 at 9:01 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > Add DT binding documentation for the Linux driver for the SiFive
> > asynchronous serial IP block.
> >
> > This revision incorporates changes based on feedback from Rob
> > Herring <robh@kernel.org>.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  .../bindings/serial/sifive-serial.txt         | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

> However, what about flow-control configuration? You'd better think now
> about what the default is and overriding that.

The underlying IP doesn't support it.

https://github.com/sifive/riscv-linux/blob/dev/paulw/dts-v5.1-rc6-experimental/drivers/tty/serial/sifive.c#L30


- Paul
