From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 04/10] mailbox: tegra-hsp: Add support for shared
 mailboxes
Date: Tue, 13 Nov 2018 14:09:17 +0100
Message-ID: <20181113130917.GA2724@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-5-thierry.reding@gmail.com>
 <fe9e6383-3735-0d07-d8d1-01199190b3a4@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5417442263510717740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <fe9e6383-3735-0d07-d8d1-01199190b3a4@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============5417442263510717740==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 11:09:22AM +0000, Jon Hunter wrote:
>=20
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> > registers consisting of a FULL bit in MSB position and 31 bits of data.
> > The hardware can be configured to trigger interrupts when a mailbox
> > is empty or full. Add support for these shared mailboxes to the HSP
> > driver.
> >=20
> > The initial use for the mailboxes is the Tegra Combined UART. For this
> > purpose, we use interrupts to receive data, and spinning to wait for
> > the transmit mailbox to be emptied to minimize unnecessary overhead.
> >=20
> > Based on work by Mikko Perttunen <mperttunen@nvidia.com>.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - do not write per-mailbox interrupt enable registers on Tegra186
> > - merge handlers for empty and full interrupts
> > - track direction of shared mailboxes
> >=20
> >  drivers/mailbox/tegra-hsp.c | 498 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 437 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> > index 0cde356c11ab..0100a974149b 100644
> > --- a/drivers/mailbox/tegra-hsp.c
> > +++ b/drivers/mailbox/tegra-hsp.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> > + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
> >   *
> >   * This program is free software; you can redistribute it and/or modif=
y it
> >   * under the terms and conditions of the GNU General Public License,
> > @@ -11,6 +11,7 @@
> >   * more details.
> >   */
> > =20
> > +#include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/mailbox_controller.h>
> > @@ -21,6 +22,17 @@
> > =20
> >  #include <dt-bindings/mailbox/tegra186-hsp.h>
> > =20
> > +#include "mailbox.h"
> > +
> > +#define HSP_INT_IE(x)		(0x100 + ((x) * 4))
> > +#define HSP_INT_IV		0x300
> > +#define HSP_INT_IR		0x304
> > +
> > +#define HSP_INT_EMPTY_SHIFT	0
> > +#define HSP_INT_EMPTY_MASK	0xff
> > +#define HSP_INT_FULL_SHIFT	8
> > +#define HSP_INT_FULL_MASK	0xff
> > +
> >  #define HSP_INT_DIMENSIONING	0x380
> >  #define HSP_nSM_SHIFT		0
> >  #define HSP_nSS_SHIFT		4
> > @@ -34,6 +46,11 @@
> >  #define HSP_DB_RAW	0x8
> >  #define HSP_DB_PENDING	0xc
> > =20
> > +#define HSP_SM_SHRD_MBOX	0x0
> > +#define HSP_SM_SHRD_MBOX_FULL	BIT(31)
> > +#define HSP_SM_SHRD_MBOX_FULL_INT_IE	0x04
> > +#define HSP_SM_SHRD_MBOX_EMPTY_INT_IE	0x08
> > +
> >  #define HSP_DB_CCPLEX		1
> >  #define HSP_DB_BPMP		3
> >  #define HSP_DB_MAX		7
> > @@ -55,6 +72,12 @@ struct tegra_hsp_doorbell {
> >  	unsigned int index;
> >  };
> > =20
> > +struct tegra_hsp_mailbox {
> > +	struct tegra_hsp_channel channel;
> > +	unsigned int index;
> > +	bool producer;
> > +};
> > +
> >  struct tegra_hsp_db_map {
> >  	const char *name;
> >  	unsigned int master;
> > @@ -63,13 +86,18 @@ struct tegra_hsp_db_map {
> > =20
> >  struct tegra_hsp_soc {
> >  	const struct tegra_hsp_db_map *map;
> > +	bool has_per_mb_ie;
> >  };
> > =20
> >  struct tegra_hsp {
> > +	struct device *dev;
> >  	const struct tegra_hsp_soc *soc;
> > -	struct mbox_controller mbox;
> > +	struct mbox_controller mbox_db;
> > +	struct mbox_controller mbox_sm;
> >  	void __iomem *regs;
> > -	unsigned int irq;
> > +	unsigned int doorbell_irq;
> > +	unsigned int *shared_irqs;
> > +	unsigned int shared_irq;
> >  	unsigned int num_sm;
> >  	unsigned int num_as;
> >  	unsigned int num_ss;
> > @@ -78,13 +106,10 @@ struct tegra_hsp {
> >  	spinlock_t lock;
> > =20
> >  	struct list_head doorbells;
> > -};
> > +	struct tegra_hsp_mailbox *mailboxes;
> > =20
> > -static inline struct tegra_hsp *
> > -to_tegra_hsp(struct mbox_controller *mbox)
> > -{
> > -	return container_of(mbox, struct tegra_hsp, mbox);
> > -}
> > +	unsigned long mask;
> > +};
> > =20
> >  static inline u32 tegra_hsp_readl(struct tegra_hsp *hsp, unsigned int =
offset)
> >  {
> > @@ -158,7 +183,7 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, =
void *data)
> > =20
> >  	spin_lock(&hsp->lock);
> > =20
> > -	for_each_set_bit(master, &value, hsp->mbox.num_chans) {
> > +	for_each_set_bit(master, &value, hsp->mbox_db.num_chans) {
> >  		struct tegra_hsp_doorbell *db;
> > =20
> >  		db =3D __tegra_hsp_doorbell_get(hsp, master);
> > @@ -182,6 +207,71 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq,=
 void *data)
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
> > +{
> > +	struct tegra_hsp *hsp =3D data;
> > +	unsigned long bit, mask;
> > +	u32 status, value;
> > +	void *msg;
> > +
> > +	status =3D tegra_hsp_readl(hsp, HSP_INT_IR) & hsp->mask;
> > +
> > +	/* process EMPTY interrupts first */
> > +	mask =3D (status >> HSP_INT_EMPTY_SHIFT) & HSP_INT_EMPTY_MASK;
> > +
> > +	for_each_set_bit(bit, &mask, hsp->num_sm) {
> > +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[bit];
> > +
> > +		if (mb->producer) {
> > +			/*
> > +			 * Disable EMPTY interrupts until data is sent with
> > +			 * the next message. These interrupts are level-
> > +			 * triggered, so if we kept them enabled they would
> > +			 * constantly trigger until we next write data into
> > +			 * the message.
> > +			 */
> > +			spin_lock(&hsp->lock);
> > +
> > +			hsp->mask &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> > +			tegra_hsp_writel(hsp, hsp->mask,
> > +					 HSP_INT_IE(hsp->shared_irq));
> > +
> > +			spin_unlock(&hsp->lock);
> > +
> > +			mbox_chan_txdone(mb->channel.chan, 0);
> > +		}
> > +	}
> > +
> > +	/* process FULL interrupts */
> > +	mask =3D (status >> HSP_INT_FULL_SHIFT) & HSP_INT_FULL_MASK;
> > +
> > +	for_each_set_bit(bit, &mask, hsp->num_sm) {
> > +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[bit];
> > +
> > +		if (!mb->producer) {
> > +			value =3D tegra_hsp_channel_readl(&mb->channel,
> > +							HSP_SM_SHRD_MBOX);
> > +			value &=3D ~HSP_SM_SHRD_MBOX_FULL;
> > +			msg =3D (void *)(unsigned long)value;
> > +			mbox_chan_received_data(mb->channel.chan, msg);
> > +
> > +			/*
> > +			 * Need to clear all bits here since some producers,
> > +			 * such as TCU, depend on fields in the register
> > +			 * getting cleared by the consumer.
> > +			 *
> > +			 * The mailbox API doesn't give the consumers a way
> > +			 * of doing that explicitly, so we have to make sure
> > +			 * we cover all possible cases.
> > +			 */
> > +			tegra_hsp_channel_writel(&mb->channel, 0x0,
> > +						 HSP_SM_SHRD_MBOX);
> > +		}
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static struct tegra_hsp_channel *
> >  tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
> >  			  unsigned int master, unsigned int index)
> > @@ -194,7 +284,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, co=
nst char *name,
> >  	if (!db)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > -	offset =3D (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
> > +	offset =3D (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_6=
4K;
> >  	offset +=3D index * 0x100;
> > =20
> >  	db->channel.regs =3D hsp->regs + offset;
> > @@ -235,8 +325,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_c=
han *chan)
> >  	unsigned long flags;
> >  	u32 value;
> > =20
> > -	if (db->master >=3D hsp->mbox.num_chans) {
> > -		dev_err(hsp->mbox.dev,
> > +	if (db->master >=3D chan->mbox->num_chans) {
> > +		dev_err(chan->mbox->dev,
> >  			"invalid master ID %u for HSP channel\n",
> >  			db->master);
> >  		return -EINVAL;
> > @@ -281,46 +371,168 @@ static void tegra_hsp_doorbell_shutdown(struct m=
box_chan *chan)
> >  	spin_unlock_irqrestore(&hsp->lock, flags);
> >  }
> > =20
> > -static const struct mbox_chan_ops tegra_hsp_doorbell_ops =3D {
> > +static const struct mbox_chan_ops tegra_hsp_db_ops =3D {
> >  	.send_data =3D tegra_hsp_doorbell_send_data,
> >  	.startup =3D tegra_hsp_doorbell_startup,
> >  	.shutdown =3D tegra_hsp_doorbell_shutdown,
> >  };
> > =20
> > -static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mb=
ox,
> > +static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *d=
ata)
> > +{
> > +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> > +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> > +	unsigned long flags;
> > +	u32 value;
> > +
> > +	WARN_ON(!mb->producer);
>=20
> Should we return here?

Yeah, that's a good idea. I made this return -EPERM for lack of a better
error code.

> > +
> > +	/* copy data and mark mailbox full */
> > +	value =3D (u32)(unsigned long)data;
> > +	value |=3D HSP_SM_SHRD_MBOX_FULL;
> > +
> > +	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
> > +
> > +	if (!irqs_disabled()) {
> > +		/* enable EMPTY interrupt for the shared mailbox */
> > +		spin_lock_irqsave(&hsp->lock, flags);
> > +
> > +		hsp->mask |=3D BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> > +		tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
> > +
> > +		spin_unlock_irqrestore(&hsp->lock, flags);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
> > +				   unsigned long timeout)
> > +{
> > +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> > +	struct tegra_hsp_channel *ch =3D &mb->channel;
> > +	u32 value;
> > +
> > +	timeout =3D jiffies + msecs_to_jiffies(timeout);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		value =3D tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
> > +		if ((value & HSP_SM_SHRD_MBOX_FULL) =3D=3D 0) {
> > +			mbox_chan_txdone(chan, 0);
> > +			return 0;
> > +		}
> > +
> > +		udelay(1);
> > +	}
> > +
> > +	return -ETIME;
> > +}
> > +
> > +static int tegra_hsp_mailbox_startup(struct mbox_chan *chan)
> > +{
> > +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> > +	struct tegra_hsp_channel *ch =3D &mb->channel;
> > +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> > +	unsigned long flags;
> > +
> > +	chan->txdone_method =3D TXDONE_BY_IRQ;
> > +
> > +	/*
> > +	 * Shared mailboxes start out as consumers by default. FULL and EMPTY
> > +	 * interrupts are coalesced at the same shared interrupt.
> > +	 *
> > +	 * Keep EMPTY interrupts disabled at startup and only enable them when
> > +	 * the mailbox is actually full. This is required because the FULL and
> > +	 * EMPTY interrupts are level-triggered, so keeping EMPTY interrupts
> > +	 * enabled all the time would cause an interrupt storm while mailboxes
> > +	 * are idle.
> > +	 */
> > +
> > +	spin_lock_irqsave(&hsp->lock, flags);
> > +
> > +	if (mb->producer)
> > +		hsp->mask &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> > +	else
> > +		hsp->mask |=3D BIT(HSP_INT_FULL_SHIFT + mb->index);
> > +
> > +	tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
> > +
> > +	spin_unlock_irqrestore(&hsp->lock, flags);
> > +
> > +	if (hsp->soc->has_per_mb_ie) {
> > +		if (mb->producer)
> > +			tegra_hsp_channel_writel(ch, 0x0,
> > +						 HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
> > +		else
> > +			tegra_hsp_channel_writel(ch, 0x1,
> > +						 HSP_SM_SHRD_MBOX_FULL_INT_IE);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void tegra_hsp_mailbox_shutdown(struct mbox_chan *chan)
> > +{
> > +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> > +	struct tegra_hsp_channel *ch =3D &mb->channel;
> > +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> > +	unsigned long flags;
> > +
> > +	if (hsp->soc->has_per_mb_ie) {
> > +		if (mb->producer)
> > +			tegra_hsp_channel_writel(ch, 0x0,
> > +						 HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
> > +		else
> > +			tegra_hsp_channel_writel(ch, 0x0,
> > +						 HSP_SM_SHRD_MBOX_FULL_INT_IE);
> > +	}
> > +
> > +	spin_lock_irqsave(&hsp->lock, flags);
> > +
> > +	if (mb->producer)
> > +		hsp->mask &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> > +	else
> > +		hsp->mask &=3D ~BIT(HSP_INT_FULL_SHIFT + mb->index);
> > +
> > +	tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
> > +
> > +	spin_unlock_irqrestore(&hsp->lock, flags);
> > +}
> > +
> > +static const struct mbox_chan_ops tegra_hsp_sm_ops =3D {
> > +	.send_data =3D tegra_hsp_mailbox_send_data,
> > +	.flush =3D tegra_hsp_mailbox_flush,
> > +	.startup =3D tegra_hsp_mailbox_startup,
> > +	.shutdown =3D tegra_hsp_mailbox_shutdown,
> > +};
> > +
> > +static struct mbox_chan *tegra_hsp_db_xlate(struct mbox_controller *mb=
ox,
> >  					    const struct of_phandle_args *args)
> >  {
> > +	struct tegra_hsp *hsp =3D container_of(mbox, struct tegra_hsp, mbox_d=
b);
> > +	unsigned int type =3D args->args[0], master =3D args->args[1];
> >  	struct tegra_hsp_channel *channel =3D ERR_PTR(-ENODEV);
> > -	struct tegra_hsp *hsp =3D to_tegra_hsp(mbox);
> > -	unsigned int type =3D args->args[0];
> > -	unsigned int master =3D args->args[1];
> >  	struct tegra_hsp_doorbell *db;
> >  	struct mbox_chan *chan;
> >  	unsigned long flags;
> >  	unsigned int i;
> > =20
> > -	switch (type) {
> > -	case TEGRA_HSP_MBOX_TYPE_DB:
> > -		db =3D tegra_hsp_doorbell_get(hsp, master);
> > -		if (db)
> > -			channel =3D &db->channel;
> > +	if (type !=3D TEGRA_HSP_MBOX_TYPE_DB || !hsp->doorbell_irq)
> > +		return ERR_PTR(-ENODEV);
> > =20
> > -		break;
> > -
> > -	default:
> > -		break;
> > -	}
> > +	db =3D tegra_hsp_doorbell_get(hsp, master);
> > +	if (db)
> > +		channel =3D &db->channel;
> > =20
> >  	if (IS_ERR(channel))
> >  		return ERR_CAST(channel);
> > =20
> >  	spin_lock_irqsave(&hsp->lock, flags);
> > =20
> > -	for (i =3D 0; i < hsp->mbox.num_chans; i++) {
> > -		chan =3D &hsp->mbox.chans[i];
> > +	for (i =3D 0; i < mbox->num_chans; i++) {
> > +		chan =3D &mbox->chans[i];
> >  		if (!chan->con_priv) {
> > -			chan->con_priv =3D channel;
> >  			channel->chan =3D chan;
> > +			chan->con_priv =3D db;
> >  			break;
> >  		}
> > =20
> > @@ -332,6 +544,29 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct=
 mbox_controller *mbox,
> >  	return chan ?: ERR_PTR(-EBUSY);
> >  }
> > =20
> > +static struct mbox_chan *tegra_hsp_sm_xlate(struct mbox_controller *mb=
ox,
> > +					    const struct of_phandle_args *args)
> > +{
> > +	struct tegra_hsp *hsp =3D container_of(mbox, struct tegra_hsp, mbox_s=
m);
> > +	unsigned int type =3D args->args[0], index;
> > +	struct tegra_hsp_mailbox *mb;
> > +
> > +	index =3D args->args[1] & TEGRA_HSP_SM_MASK;
> > +
> > +	if (type !=3D TEGRA_HSP_MBOX_TYPE_SM || !hsp->shared_irqs ||
> > +	    index >=3D hsp->num_sm)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	mb =3D &hsp->mailboxes[index];
> > +
> > +	if ((args->args[1] & TEGRA_HSP_SM_FLAG_TX) =3D=3D 0)
> > +		mb->producer =3D false;
> > +	else
> > +		mb->producer =3D true;
> > +
> > +	return mb->channel.chan;
> > +}
> > +
> >  static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
> >  {
> >  	struct tegra_hsp_doorbell *db, *tmp;
> > @@ -364,10 +599,65 @@ static int tegra_hsp_add_doorbells(struct tegra_h=
sp *hsp)
> >  	return 0;
> >  }
> > =20
> > +static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct devic=
e *dev)
> > +{
> > +	int i;
> > +
> > +	hsp->mailboxes =3D devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailbo=
xes),
> > +				      GFP_KERNEL);
> > +	if (!hsp->mailboxes)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < hsp->num_sm; i++) {
> > +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> > +
> > +		mb->index =3D i;
> > +
> > +		mb->channel.hsp =3D hsp;
> > +		mb->channel.regs =3D hsp->regs + SZ_64K + i * SZ_32K;
> > +		mb->channel.chan =3D &hsp->mbox_sm.chans[i];
> > +		mb->channel.chan->con_priv =3D mb;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_hsp_request_shared_irqs(struct tegra_hsp *hsp)
> > +{
> > +	unsigned int i, irq =3D 0;
> > +	int err;
> > +
> > +	for (i =3D 0; i < hsp->num_si; i++) {
> > +		if (hsp->shared_irq =3D=3D 0 && hsp->shared_irqs[i] > 0) {
> > +			irq =3D hsp->shared_irqs[i];
> > +			hsp->shared_irq =3D i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (irq > 0) {
> > +		err =3D devm_request_irq(hsp->dev, irq, tegra_hsp_shared_irq, 0,
> > +				       dev_name(hsp->dev), hsp);
> > +		if (err < 0) {
> > +			dev_err(hsp->dev, "failed to request interrupt: %d\n",
> > +				err);
> > +			return err;
> > +		}
>=20
> Are we suppose to loop through all the shared interrupts and find one
> that is available? Looking at the above it seems that we will try to use
> the first shared interrupt we have a valid mapping for, regardless of if
> it is available/in-use.
>=20
> Otherwise I am not sure why it is necessary to stored all the shared
> irqs, because AFAICT we only use the first we have a valid mapping for.
> Maybe I am missing something ...

Yeah, that's a good idea. In practice I don't think this matters at all
because there just isn't another user of these interrupts, but it might
be more explicit and self-explanatory if we try all of the interrupts
in turn until we can request one.

> > +
> > +		/* disable all interrupts */
> > +		tegra_hsp_writel(hsp, 0, HSP_INT_IE(hsp->shared_irq)> +
> > +		dev_dbg(hsp->dev, "interrupt requested: %u\n", irq);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int tegra_hsp_probe(struct platform_device *pdev)
> >  {
> >  	struct tegra_hsp *hsp;
> >  	struct resource *res;
> > +	unsigned int i;
> >  	u32 value;
> >  	int err;
> > =20
> > @@ -375,6 +665,7 @@ static int tegra_hsp_probe(struct platform_device *=
pdev)
> >  	if (!hsp)
> >  		return -ENOMEM;
> > =20
> > +	hsp->dev =3D &pdev->dev;
> >  	hsp->soc =3D of_device_get_match_data(&pdev->dev);
> >  	INIT_LIST_HEAD(&hsp->doorbells);
> >  	spin_lock_init(&hsp->lock);
> > @@ -392,58 +683,136 @@ static int tegra_hsp_probe(struct platform_devic=
e *pdev)
> >  	hsp->num_si =3D (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
> > =20
> >  	err =3D platform_get_irq_byname(pdev, "doorbell");
> > -	if (err < 0) {
> > -		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
> > -		return err;
> > +	if (err >=3D 0)
> > +		hsp->doorbell_irq =3D err;
> > +
> > +	if (hsp->num_si > 0) {
> > +		unsigned int count =3D 0;
> > +
> > +		hsp->shared_irqs =3D devm_kcalloc(&pdev->dev, hsp->num_si,
> > +						sizeof(*hsp->shared_irqs),
> > +						GFP_KERNEL);
> > +		if (!hsp->shared_irqs)
> > +			return -ENOMEM;
> > +
> > +		for (i =3D 0; i < hsp->num_si; i++) {
> > +			char *name;
> > +
> > +			name =3D kasprintf(GFP_KERNEL, "shared%u", i);
> > +			if (!name)
> > +				return -ENOMEM;
> > +
> > +			err =3D platform_get_irq_byname(pdev, name);
> > +			if (err >=3D 0) {
> > +				hsp->shared_irqs[i] =3D err;
> > +				count++;
> > +			}
> > +
> > +			kfree(name);
> > +		}
> > +
> > +		if (count =3D=3D 0) {
> > +			devm_kfree(&pdev->dev, hsp->shared_irqs);
> > +			hsp->shared_irqs =3D NULL;
> > +		}
> > +	}
> > +
> > +	/* setup the doorbell controller */
> > +	hsp->mbox_db.of_xlate =3D tegra_hsp_db_xlate;
> > +	hsp->mbox_db.num_chans =3D 32;
> > +	hsp->mbox_db.dev =3D &pdev->dev;
> > +	hsp->mbox_db.ops =3D &tegra_hsp_db_ops;
> > +
> > +	hsp->mbox_db.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox_db.num_chan=
s,
> > +					  sizeof(*hsp->mbox_db.chans),
> > +					  GFP_KERNEL);
> > +	if (!hsp->mbox_db.chans)
> > +		return -ENOMEM;
> > +
> > +	if (hsp->doorbell_irq) {
> > +		err =3D tegra_hsp_add_doorbells(hsp);
> > +		if (err < 0) {
> > +			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
> > +			        err);
> > +			return err;
> > +		}
> >  	}
> > =20
> > -	hsp->irq =3D err;
> > +	err =3D mbox_controller_register(&hsp->mbox_db);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to register doorbell mailbox: %d\n", err=
);
> > +		goto remove_doorbells;
> > +	}
> > =20
> > -	hsp->mbox.of_xlate =3D of_tegra_hsp_xlate;
> > -	hsp->mbox.num_chans =3D 32;
> > -	hsp->mbox.dev =3D &pdev->dev;
> > -	hsp->mbox.txdone_irq =3D false;
> > -	hsp->mbox.txdone_poll =3D false;
> > -	hsp->mbox.ops =3D &tegra_hsp_doorbell_ops;
> > +	/* setup the shared mailbox controller */
> > +	hsp->mbox_sm.of_xlate =3D tegra_hsp_sm_xlate;
> > +	hsp->mbox_sm.num_chans =3D hsp->num_sm;
> > +	hsp->mbox_sm.dev =3D &pdev->dev;
> > +	hsp->mbox_sm.ops =3D &tegra_hsp_sm_ops;
> > =20
> > -	hsp->mbox.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox.num_chans,
> > -					sizeof(*hsp->mbox.chans),
> > -					GFP_KERNEL);
> > -	if (!hsp->mbox.chans)
> > +	hsp->mbox_sm.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox_sm.num_chan=
s,
> > +					  sizeof(*hsp->mbox_sm.chans),
> > +					  GFP_KERNEL);
> > +	if (!hsp->mbox_sm.chans)
> >  		return -ENOMEM;
> > =20
> > -	err =3D tegra_hsp_add_doorbells(hsp);
> > +	if (hsp->shared_irqs) {
> > +		err =3D tegra_hsp_add_mailboxes(hsp, &pdev->dev);
> > +		if (err < 0) {
> > +			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
> > +			        err);
> > +			goto unregister_mbox_db;
> > +		}
> > +	}
> > +
> > +	err =3D mbox_controller_register(&hsp->mbox_sm);
> >  	if (err < 0) {
> > -		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
> > -		return err;
> > +		dev_err(&pdev->dev, "failed to register shared mailbox: %d\n", err);
> > +		goto unregister_mbox_db;
> >  	}
> > =20
> >  	platform_set_drvdata(pdev, hsp);
> > =20
> > -	err =3D mbox_controller_register(&hsp->mbox);
> > -	if (err) {
> > -		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
> > -		tegra_hsp_remove_doorbells(hsp);
> > -		return err;
> > +	if (hsp->doorbell_irq) {
> > +		err =3D devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> > +				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> > +				       dev_name(&pdev->dev), hsp);
> > +		if (err < 0) {
> > +			dev_err(&pdev->dev,
> > +			        "failed to request doorbell IRQ#%u: %d\n",
> > +				hsp->doorbell_irq, err);
> > +			goto unregister_mbox_sm;
> > +		}
> >  	}
> > =20
> > -	err =3D devm_request_irq(&pdev->dev, hsp->irq, tegra_hsp_doorbell_irq,
> > -			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), hsp);
> > -	if (err < 0) {
> > -		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> > -			hsp->irq, err);
> > -		return err;
> > +	if (hsp->shared_irqs) {
> > +		err =3D tegra_hsp_request_shared_irqs(hsp);
> > +		if (err < 0)
> > +			goto unregister_mbox_sm;
>=20
> Any reason why we don't request the doorbell and shared irqs earlier?
> Given we use devm seems it could simplify the clean and avoid
> unregistering the mailbox.

The interrupt handlers need to access the fields that are set up in the
above sequence, so if we request them earlier they may run without this
data being initialized and crash. Now, since we disable the shared
interrupts that shouldn't happen, but better to be safe than sorry.

Thierry

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvqzPoACgkQ3SOs138+
s6Eq2BAAvYsYM4CTdw1C4c4BGLR1ZfhRxfIKFla/2pK2mCyYvgd+EiYylgdN/3jf
s+xKvvufNwQ5aZtSri5oDaKCvdp+q+pX3wCuMyLNYMkWJCQi7f4QTGYEhWTZCvcP
n1UOUQvGWQv99K0/1uNS/ncuSzv7vSM6K1v/EuPncuO61KxL0EuHTZfDK1+wN9TW
Vb6qIwWfVmOR2GkAivbeHCXNp7rSlfvVe0g+WjRltYbRYPsH1FiD7va9RqVIEnF9
oI3hij71INCnf5tY6RV3aZgmGn0z61kT1MkUpC+NQ8XDM0jS75tmAa5BwLOYagsS
gziALGiplgJ/3KKVi24aN+Wi5yZkv6zDDyIX4CQ5fkPb4FFytXK3O8GbyGbB84X0
L5ndtfRm5ZBECsy7wo5u+CJYUHsh4L2ZXq1a1W1jsxiHRwAs6Xl9mIvFrw7ikYyN
UmdgA3Ulv8CyEo5VO3Mkv8KxY8+0xzaiaQghhkHFaV5n+M9DoE6P1fo/XxtBFMTh
MgRY4qPfQP1mXpjjehLsDwmzHuBFdbxPvsG+z/SQRw8VYVAZSs740zFNvZiN+xal
xPa3MQ/gmjbUzcNLcd8h6FojgUxI5K1cMLJhHPABTzDLI4v9Pt1DzA4H49BM6BxL
/eQK0XjyxNdAfjHRFaHL3N19R3gaYauB1+qDJFG6UwrzWSpKlFI=
=xHTo
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--


--===============5417442263510717740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5417442263510717740==--
