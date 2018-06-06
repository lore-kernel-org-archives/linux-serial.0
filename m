From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
Date: Wed, 6 Jun 2018 11:36:40 +0200
Message-ID: <2654fba0-e16e-4f53-4913-bd718e42497c@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
 <b14d4970-f14d-d59f-2072-b7d5704dd842@gmail.com>
 <d130718a-444d-3a39-4da8-0f0b907f850d@micronovasrl.com>
 <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Il 05/06/2018 12:51, Matwey V. Kornilov ha scritto:
> Could I ask to split the series into fixes and new features? I see
> that the fixes can be applied, probably it would be better to apply
> them separately from discussing new features.

Sure, I'm going to send 2 different patchsets.

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
