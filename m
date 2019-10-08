From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Date: Tue, 8 Oct 2019 17:04:56 +0200
Message-ID: <20191008150456.GA2683@pi3>
References: <20191004151414.8458-1-krzk@kernel.org>
 <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
 <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
 <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
 <20191008142900.GA2635@pi3>
 <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maciej Falkowski <m.falkowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 08, 2019 at 09:38:15AM -0500, Rob Herring wrote:
> Are you running using DT_SCHEMA_FILES? If so, you won't get the core schema.

Ah, yes, now I see proper errors. Thanks for pointing this.

I'll send next version of this patch only (if others are ok).

Best regards,
Krzysztof
