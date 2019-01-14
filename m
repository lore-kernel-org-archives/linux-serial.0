From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
Date: Mon, 14 Jan 2019 10:23:15 -0600
Message-ID: <CAL_JsqJd_kHi+XU7_oe0upg1iJT2rjjEup3YpyrDQA-OhkgKTw@mail.gmail.com>
References: <20190110222017.6390-1-robh@kernel.org> <20190114093022.hjouckoss2zemefg@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114093022.hjouckoss2zemefg@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 14, 2019 at 3:30 AM Simon Horman <horms@verge.net.au> wrote:
>
> On Thu, Jan 10, 2019 at 04:20:16PM -0600, Rob Herring wrote:
> > Convert the snps,dw-apb-uart binding to DT schema using json-schema.
> >
> > The Rockchip and Broadcom compatible strings were not documented,
> > so add them here.
>
> I believe the documentation of the Renesas compatible strings is also new
> in this file. Perhaps it would be worth mentioning that too.

Ah, that should be in patch 2. Will respin.

> In any case
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
