From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] dmaengine: rename cmd_pause to cmd_suspend
Date: Tue, 10 May 2016 19:00:23 +0300
Message-ID: <1462896023.17131.305.camel@linux.intel.com>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462390180-82368-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160510155928.GH2274@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160510155928.GH2274@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-05-10 at 21:29 +0530, Vinod Koul wrote:
> On Wed, May 04, 2016 at 10:29:40PM +0300, Andy Shevchenko wrote:
> >=20
> > Rename cmd_pause to cmd_suspend to be clear that latter capability
> > reflects
> > pause AND resume.
> How does cmd_suspend be any clearer to reflect that channel is paused
> and
> not. One can argue this might be related to power management suspend=20

Okay, I'm open to suggestions. My main point that name should not
represent only pause or resume, rather both.

> ...
>=20
> >=20
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/dma/dmaengine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0drivers/tty/serial/8250/8250_dma.c=C2=A0=C2=A0=C2=A0=C2=A0| 2=
 +-
> > =C2=A0include/linux/dmaengine.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
> > =C2=A04 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 59eb4fa..e9917a4 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -503,9 +503,9 @@ int dma_get_slave_caps(struct dma_chan *chan,
> > struct dma_slave_caps *caps)
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	=C2=A0* Some devices implement only pause (e.g. to get resid=
uum)
> > but no
> > -	=C2=A0* resume. However cmd_pause is advertised as pause AND
> > resume.
> > +	=C2=A0* resume. However cmd_suspend is advertised as pause AND
> > resume.
> > =C2=A0	=C2=A0*/
> > -	caps->cmd_pause =3D !!(device->device_pause && device-
> > >device_resume);
> > +	caps->cmd_suspend =3D !!(device->device_pause && device-
> > >device_resume);
> > =C2=A0	caps->cmd_terminate =3D !!device->device_terminate_all;
> > =C2=A0
> > =C2=A0	return 0;
> > diff --git a/drivers/tty/serial/8250/8250_dma.c
> > b/drivers/tty/serial/8250/8250_dma.c
> > index 8ccbf53..2db57b0 100644
> > --- a/drivers/tty/serial/8250/8250_dma.c
> > +++ b/drivers/tty/serial/8250/8250_dma.c
> > @@ -180,7 +180,7 @@ int serial8250_request_dma(struct uart_8250_por=
t
> > *p)
> > =C2=A0	ret =3D dma_get_slave_caps(dma->rxchan, &caps);
> > =C2=A0	if (ret)
> > =C2=A0		goto release_rx;
> > -	if (!caps.cmd_pause || !caps.cmd_terminate ||
> > +	if (!caps.cmd_suspend || !caps.cmd_terminate ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0caps.residue_granularity =3D=3D
> > DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
> > =C2=A0		ret =3D -EINVAL;
> > =C2=A0		goto release_rx;
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 30de019..af9c97c 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -402,7 +402,7 @@ enum dma_residue_granularity {
> > =C2=A0 *=C2=A0	type of direction, the dma controller should fill (1=
 <<
> > <TYPE>) and same
> > =C2=A0 *=C2=A0	should be checked by controller as well
> > =C2=A0 * @max_burst: max burst capability per-transfer
> > - * @cmd_pause: true, if pause and thereby resume is supported
> > + * @cmd_suspend: true, if pause and thereby resume is supported
> > =C2=A0 * @cmd_terminate: true, if terminate cmd is supported
> > =C2=A0 * @residue_granularity: granularity of the reported transfer
> > residue
> > =C2=A0 * @descriptor_reuse: if a descriptor can be reused by client=
 and
> > @@ -413,7 +413,7 @@ struct dma_slave_caps {
> > =C2=A0	u32 dst_addr_widths;
> > =C2=A0	u32 directions;
> > =C2=A0	u32 max_burst;
> > -	bool cmd_pause;
> > +	bool cmd_suspend;
> > =C2=A0	bool cmd_terminate;
> > =C2=A0	enum dma_residue_granularity residue_granularity;
> > =C2=A0	bool descriptor_reuse;
> > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-
> > generic-dmaengine-pcm.c
> > index 6cef397..73fc20e 100644
> > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> > @@ -151,7 +151,7 @@ static int
> > dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream
> > *substrea
> > =C2=A0
> > =C2=A0	ret =3D dma_get_slave_caps(chan, &dma_caps);
> > =C2=A0	if (ret =3D=3D 0) {
> > -		if (dma_caps.cmd_pause)
> > +		if (dma_caps.cmd_suspend)
> > =C2=A0			hw.info |=3D SNDRV_PCM_INFO_PAUSE |
> > SNDRV_PCM_INFO_RESUME;
> > =C2=A0		if (dma_caps.residue_granularity <=3D
> > DMA_RESIDUE_GRANULARITY_SEGMENT)
> > =C2=A0			hw.info |=3D SNDRV_PCM_INFO_BATCH;
> > --=C2=A0
> > 2.8.1
> >=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
