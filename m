From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/4] serial: s5pv210: Add device tree support
Date: Wed, 3 Aug 2011 11:09:23 +0100
Message-ID: <CAJuYYwSg8XcdRqD1VHzsL4oGtJkCdhAM9mpSX_jQnGr0BKz2PQ@mail.gmail.com>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
	<1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
	<20110803091249.GB28651@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46976 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1HCKJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Aug 2011 06:09:24 -0400
In-Reply-To: <20110803091249.GB28651@trinity.fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com, patches@linaro.org, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ben,

On 3 August 2011 10:12, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Aug 03, 2011 at 12:08:27AM +0100, Thomas Abraham wrote:
>> For device tree based probe, the dependecy on pdev->id to attach a
>> corresponding default port info to the driver's private data is
>> removed. The fifosize parameter is obtained from the device tree
>> node and the next available instance of port info is updated
>> with the fifosize value and attached to the driver's private data.
>> The default platform data is selected based on the compatible proper=
ty.
>>
>> CC: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/serial/samsung_uart.txt =A0 =A0| =A0 16 +=
++++++
>> =A0drivers/tty/serial/s5pv210.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 43 +++++++++++++++++++-
>> =A0drivers/tty/serial/samsung.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A05 ++-
>> =A03 files changed, 62 insertions(+), 2 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/serial/samsu=
ng_uart.txt

[...]

>>
>> +
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pdev->dev.of_node=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "samsung,u=
art-fifosize",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &s5p_uart_=
inf[probe_index]->fifosize))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> I'd rather see the fifo size either being a property of the soc itsel=
f
> or being inferred by the compatible field.

Ok. I missed that. I will make it part of the SoC data.

>
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "s5pv210-uart",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D s5pv210_uart_dt_match,
>
> I think maybe doing something like
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D of_match_ptr(5pv21=
0_uart_dt_match),
>
> so we can avoid having the #else and #define 5pv210_uart_dt_match NUL=
L
> in a number of places.

Ok. I will change it.

Thanks,
Thomas.

>
>> =A0 =A0 =A0 },
>> =A0};
>
> --
> Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disa=
ppear.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
