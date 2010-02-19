From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/2] Add DMA support for the sh-sci.c serial driver
Date: Fri, 19 Feb 2010 15:42:52 +0530
Message-ID: <d6a0f7aa1002190212g556341fy8c590f842d746fb0@mail.gmail.com>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
	 <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
	 <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
	 <Pine.LNX.4.64.1002191053220.4594@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1002191053220.4594@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 19, 2010 at 3:26 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 19 Feb 2010, Govindraj wrote:
>
>> > + =A0 =A0 =A0 chan =3D dma_request_channel(mask, filter, param);
>> > + =A0 =A0 =A0 dev_dbg(port->dev, "%s: RX: got channel %p\n", __fun=
c__, chan);
>>
>>
>> If dma channel allocation fails how this scenario will be handled,
>> There is an possibility of dma_request_channel returning -EBUSY,
>
> Really? How? I thought it could only return a pointer to a channel or=
 a
> NULL? And if it fails, i.e., chan =3D=3D NULL, the whole code just st=
ays
> inactive and the driver falls back to normal PIO.

Sorry I missed this part:

if (s->chan_tx) {

if (s->chan_rx) {


> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>

---
Regards,
Govindraj.R
