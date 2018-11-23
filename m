From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Fri, 23 Nov 2018 12:17:00 +0100
Message-ID: <20181123111700.GA31881@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
 <20181122084712.GA5741@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6890520013809506621=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181122084712.GA5741@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============6890520013809506621==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 09:47:12AM +0100, Thierry Reding wrote:
[...]
> Perhaps you'd be less concerned about such a change if it was perhaps
> more explicit? Just throwing ideas around, I think something that could
> also work is if we explicitly add a mbox_flush() function that would
> basically be calling ->flush(). That way users of the mailbox can make
> their requirement very explicit. I haven't actually tested that, but I
> think it would work. Does that sound more acceptable to you?

I tried implementing the explicit flushing on top of this series and it
would look roughly like the below. What do you think?

Thierry

--->8---
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7e2c4358aa..fbdcc82a61ae 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -267,14 +267,6 @@ int mbox_send_message(struct mbox_chan *chan, void *ms=
sg)
 		unsigned long wait;
 		int ret;
=20
-		if (irqs_disabled() && chan->mbox->ops->flush) {
-			ret =3D chan->mbox->ops->flush(chan, chan->cl->tx_tout);
-			if (ret < 0)
-				tx_tick(chan, ret);
-
-			return ret;
-		}
-
 		if (!chan->cl->tx_tout) /* wait forever */
 			wait =3D msecs_to_jiffies(3600000);
 		else
@@ -291,6 +283,34 @@ int mbox_send_message(struct mbox_chan *chan, void *ms=
sg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
=20
+/**
+ * mbox_flush - flush a mailbox channel
+ * @chan: mailbox channel to flush
+ * @timeout: time, in milliseconds, to allow the flush operation to succeed
+ *
+ * Mailbox controllers that need to work in atomic context can implement t=
he
+ * ->flush() callback to busy loop until a transmission has been completed.
+ * The implementation must call mbox_chan_txdone() upon success. Clients c=
an
+ * call the mbox_flush() function at any time after mbox_send_message() to
+ * flush the transmission. After the function returns success, the mailbox
+ * transmission is guaranteed to have completed.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
+{
+	int ret;
+
+	if (!chan->mbox->ops->flush)
+		return -ENOTSUPP;
+
+	ret =3D chan->mbox->ops->flush(chan, timeout);
+	if (ret < 0)
+		tx_tick(chan, ret);
+
+	return ret;
+}
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index f99c406cb3cc..e443f6a2ec4b 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -387,15 +387,13 @@ static int tegra_hsp_mailbox_send_data(struct mbox_ch=
an *chan, void *data)
=20
 	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
=20
-	if (!irqs_disabled()) {
-		/* enable EMPTY interrupt for the shared mailbox */
-		spin_lock_irqsave(&hsp->lock, flags);
+	/* enable EMPTY interrupt for the shared mailbox */
+	spin_lock_irqsave(&hsp->lock, flags);
=20
-		hsp->mask |=3D BIT(HSP_INT_EMPTY_SHIFT + mb->index);
-		tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
+	hsp->mask |=3D BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
=20
-		spin_unlock_irqrestore(&hsp->lock, flags);
-	}
+	spin_unlock_irqrestore(&hsp->lock, flags);
=20
 	return 0;
 }
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 1d360cd03b18..59eaa13e169e 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -57,6 +57,7 @@ static void tegra_tcu_write_one(struct tegra_tcu *tcu, u3=
2 value,
 	value |=3D TCU_MBOX_NUM_BYTES(count);
 	msg =3D (void *)(unsigned long)value;
 	mbox_send_message(tcu->tx, msg);
+	mbox_flush(tcu->tx, 1000);
 }
=20
 static void tegra_tcu_write(struct tegra_tcu *tcu, const char *s,
@@ -184,9 +185,6 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 		return -ENOMEM;
=20
 	tcu->tx_client.dev =3D &pdev->dev;
-	tcu->tx_client.tx_block =3D true;
-	tcu->tx_client.tx_tout =3D 10000;
-	tcu->rx_client.dev =3D &pdev->dev;
 	tcu->rx_client.rx_callback =3D tegra_tcu_receive;
=20
 	tcu->tx =3D mbox_request_channel_byname(&tcu->tx_client, "tx");
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 44348710953f..faa7da3c9c8b 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -44,6 +44,7 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox=
_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
+int mbox_flush(struct mbox_chan *chan, unsigned long timeout);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv34akACgkQ3SOs138+
s6HZNRAArYh1STsBeT1z7HzT16095Xt1/uAlbjIi5tZGYA/i3JNaDMfdsUNN3gxg
t+QhfaFf2LZlLZcfzHPJO9XxXPXs6R5y2XongQnE0gOSDSXoKh5gT10NbU6m8vcE
Fi0nzmIDcvxMT9s91RVlNRgJL2gV4+E6++HqnLul+lIDsSkC6pSMPOrEWbUaGB3Q
0n4w9SP+jJi33N9z8GIky5dQX5Fo0bC+hqGW9Y7uXQm8xip5sQQ+4KBpSglVdxS3
q4xYkFJlxpq2mGV4NSWWCQ2ty59ksXEf0ttQjfv2hqcpeB/xtuWw4xR3M8YvSYqz
hBFwOlIWxF60SVmUwRS/ff4dafUY2DySomTdWAi2c5ITR6cv2AqelKg4ZmDte8PK
9TAu1vf9GNTOZo1V93avu0IrPLmUyi+CNZb8cIH7Ksz23iUE+94hRChAFEo0s3NI
9z7wiW50fmrMfn2gdn9CtYHkzybg6JSTLGQ3WUBk+7o2iNQNtH0Sh/r9joefWoWR
K9cAhBWBhLbYLzbo0E+Qd32I7K/hC9Vp0/VYJqiUQ7bHmxMtZQ04K51IHHe1TG1l
wU0WBb/jHFNhLm78SExvwLBL7GHS5NNZTUjYuolyw7f0lQ4QAjoM1P3ORWf+NfNa
PJ4UhVNHrKWCiU00LL1pd6a9A6IEdRwZo6CHRRL602zl9TrG4VQ=
=nwju
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


--===============6890520013809506621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6890520013809506621==--
