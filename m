From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] dmaenegine: edma: allow pause/resume for non-cyclic
 mode
Date: Mon, 27 Apr 2015 14:55:53 +0300
Message-ID: <553E23C9.3030603@ti.com>
References: <87vbghaiva.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87vbghaiva.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On 04/27/2015 02:52 PM, John Ogness wrote:
> The 8250_omap serial driver relies on dmaengine_pause() actually
> pausing the DMA transfer. Before this patch dmaengine_pause() is
> a NOP for non-cylic DMA transfers. This allowed the 8250_omap
> driver to read DMA buffers while the DMA was still active,
> resulting in lost serial data.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/dma/edma.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index bf09db7..88853af 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -300,8 +300,7 @@ static int edma_dma_pause(struct dma_chan *chan)
>  {
>  	struct edma_chan *echan =3D to_edma_chan(chan);
> =20
> -	/* Pause/Resume only allowed with cyclic mode */
> -	if (!echan->edesc || !echan->edesc->cyclic)
> +	if (!echan->edesc)
>  		return -EINVAL;
> =20
>  	edma_pause(echan->ch_num);
> @@ -312,10 +311,6 @@ static int edma_dma_resume(struct dma_chan *chan=
)
>  {
>  	struct edma_chan *echan =3D to_edma_chan(chan);
> =20
> -	/* Pause/Resume only allowed with cyclic mode */
> -	if (!echan->edesc->cyclic)
> -		return -EINVAL;
> -
>  	edma_resume(echan->ch_num);
>  	return 0;
>  }
>=20


--=20
P=E9ter
