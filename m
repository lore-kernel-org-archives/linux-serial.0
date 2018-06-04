From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 3/8] serial: 8250: Copy em485 from port to real port.
Date: Mon, 4 Jun 2018 12:52:57 +0200
Message-ID: <893fdadf-3d46-d621-1e32-d18dd2725fc8@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-4-giulio.benetti@micronovasrl.com>
 <d282884a4df00d3f010c6af77c61ce07da75adc3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d282884a4df00d3f010c6af77c61ce07da75adc3.camel@linux.intel.com>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Il 04/06/2018 12:13, Andy Shevchenko ha scritto:
> On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
>> em485 gets lost during serial8250_register_8250_port().
>>
>> Copy em485 to final uart port.
> 
> Fixes better to go first.
> I think you need to reorder the series.

Ok, thanks.
So after re-ording and clarifying TEMT interrupt, can I send v2 patchset?

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
