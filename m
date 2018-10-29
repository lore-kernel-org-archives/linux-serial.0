From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
Date: Mon, 29 Oct 2018 14:16:14 +0100
Message-ID: <20181029131614.GA14616@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-5-thierry.reding@gmail.com>
 <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
 <20181029103937.GB26393@ulmo>
 <9dfa7669-9401-a55c-8959-8d31cf193ca7@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9dfa7669-9401-a55c-8959-8d31cf193ca7@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Pessi <ppessi@nvidia.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 02:25:42PM +0200, Pekka Pessi wrote:
> Hi Thierry,
>=20
> From the 0/9:
> > Are you aware of any others that we need to take into account?
> We would like to use upstream driver for RCE (and probably AON and SCE)
> mailbox handling, too. Eventually.
> > This is a bit
> > of a problem because the mailbox driver doesn't really know anything
> > about the direction when it starts up, so how would it make the decision
> > about how to program the registers?
> I'm afraid that information must be stored in the device tree.
> > What's somewhat surprising is that you're saying that both FULL and
> > EMPTY interrupts should be handled by the same shared interrupt. That's
> > the opposite of what the recommended programming sequence is that the
> > TRM specifies.
> Which TRM you mean? Something here?
>=20
> https://p4viewer.nvidia.com/get///hw/ar/doc/Tech_Pubs/Xavier/TRM/
>=20
> I browsed through he Xavier_TRM_DP09253001v1.pdf HSP section and I could =
not
> find any recommendations? But see below.

I'm referring to Xavier_TRM_Public.pdf in that location. If you look at
page 4422, "Shared Interrupts Configuration", the example has aggregated
EMPTY and FULL interrupts on shared interrupts 0 and 1, respectively. I
guess it being an example doesn't make it strictly a recommendation, but
I wonder if we should avoid giving examples that use mappings which we
discourage.

> > Why is it better to handle both FULL and EMPTY interrupts
> > with the same shared interrupt?
> Only top0 has 8 interrupts, rest of the HSP blocks have only 4 (or 5 in c=
ase
> of top1) interrupts per HSP available through LIC. Hogging two of them me=
ans
> that only two VMs can access a HSP.

Virtualization isn't something that we're very concerned about upstream,
but I'll take that under consideration.

> > Would it be safe to clear all of the IE registers to 0 on driver probe?
> Nope, the driver should clear only the IE register for the shared interru=
pt
> that the driver uses. Other IEs are used by other entities.

Right, that makes sense. But within that IE register it can consider all
bits fair game, right? One thing I wonder, though, is whether there
should be some external mechanism to set the shared interrupt to use. If
we go purely by convention we'll eventually get this wrong. So currently
we list all available interrupts in DT and then we could pick just the
first. But what if somebody else already picked the first and "owns" it?

I'm not sure we have any practical mechanism to rewrite the DTB, but
perhaps something to keep in mind if ever we need to support other
entities down the road.

> > If they are indeed separate
> > for each processor, it should be fairly easy to keep track of the
> > mailboxes used by the kernel and process only those.
> Yes, that is what we should do. Again the directionality should be specif=
ied
> in DT.

Currently we encode the shared mailboxes in DT like this:

	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
	mbox-names =3D "rx", "tx";

I suppose we could change that to something like:

	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM (0 << 31 | 0)>,
		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM (1 << 31 | 0)>;

Where the MSB of the mailbox index would indicate the direction. We
could maybe add some eye-candy to make it easier to read:

	mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_MBOX_SM_RX(0)>,
		 <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM TEGRA_HSP_MBOX_SM_TX(1)>;

That said, I wonder if perhaps it is safe to treat all mailboxes as
consumers by default and omit and direction in DT. If a mailbox is used
as consumer, then the CCPLEX is only interested in FULL interrupts, so
we enable those. The entity that shares the mailbox will write data to
it and is only interested in the EMPTY interrupt, which we don't touch
=66rom the CCPLEX.

For mailboxes that the CCPLEX writes to, we can reconfigure them as
producers by disabling the FULL interrupt and enabling the EMPTY
interrupt instead. We can do that the first time somebody calls the
mbox_send_message() on the mailbox.

Do you see any problems with that approach?

> > I'm not entirely clear on what the advantages are of using the per-
> > mailbox registers, or how they are supposed to be used. The existing
> > documentation doesn't really explain how these are supposed to be used
> > either, so I was mostly just going by trial and error.
> On virtualized configs, multiple VMs can use same HSP block but each VM m=
ust
> use its own interrupt. Because all the IE registers are on the same 64 KB
> page, the writes to the page are trapped by hypervisor, which means that
> enabling or disabling an interrupt via the shared IE register is pretty
> heavy operation. The per-mailbox IE registers are on a page accessed free=
ly
> by the IE, no need to trap.

Do the per-mailbox IE registers act as a second level enable, then? The
HSP driver would still have to set the IE register to aggregate FULL and
EMPTY interrupts as needed, but could then use the per-mailbox IE
registers to actually enable and disable (that is, unmask and mask) the
interrupts?

> If a VM uses only one empty mailbox interrupt, using a dedicated "shared"
> interrupt and disabling that in GIC could be a lighter operation, we used=
 to
> do that in Parker.

Okay, that seems like it would somewhat complicate things and we don't
really support VM uses yet, so I think it best to leave that out for
now.

Thierry

> On 10/29/2018 12:39 PM, Thierry Reding wrote:
> > On Mon, Oct 29, 2018 at 12:04:22PM +0200, Pekka Pessi wrote:
> > > Hi Thierry,
> > >=20
> > > There is typically one entity (aux cpu or a VM running on CCPLEX) own=
ing the
> > > "empty" or producer side of mailbox (iow, waking up on empty) and ano=
ther
> > > entity owning the "full" or consumer side of mailbox (waking up on fu=
ll). An
> > > entity should not muck with the interrupts used by the opposite side.
> > Okay, that explains some of my observations. I was initially trying to
> > program interrupt enables for both FULL and EMPTY interrupts for all
> > mailboxes, but then I'd usually get timeouts because the consumer wasn't
> > responding (i.e. the SPE wasn't getting FULL interrupts for the CCPLEX's
> > TX mailbox).
> >=20
> > If I understand correctly, you're saying that the CPU should only be
> > using the EMPTY interrupts for it's TX mailbox (while leaving the FULL
> > interrupts completely untouched) and only the FULL interrupt for it's
> > RX mailbox (while leaving the EMPTY interrupts untouched). This is a bit
> > of a problem because the mailbox driver doesn't really know anything
> > about the direction when it starts up, so how would it make the decision
> > about how to program the registers?
> >=20
> > > One entity typically owns one shared interrupt only.=C2=A0 For the
> > > BPMP/SCE/RCE/SPE HSP blocks the shared interrupt 0 is owned by the au=
xiliary
> > > processor itself, the shared interrupts 1..4 are connected to LIC and=
 are
> > > available to other entities. The convention is to go through the inte=
rrupts
> > > 0..4 and then using the first available shared interrupt for both ful=
l and
> > > empty.
> > That partially matches another of my observations. It seems like we
> > can't use the shared interrupt 0 at all on at least the AON HSP. That's
> > fine because that HSP instance contains the TX mailbox for TCU and by
> > the current convention in the HSP driver, shared interrupt 0 would be
> > aggregating the FULL interrupts, which according to the above we don't
> > need for TX mailboxes.
> >=20
> > What's somewhat surprising is that you're saying that both FULL and
> > EMPTY interrupts should be handled by the same shared interrupt. That's
> > the opposite of what the recommended programming sequence is that the
> > TRM specifies. Why is it better to handle both FULL and EMPTY interrupts
> > with the same shared interrupt?
> >=20
> > > The interrupt functions should use a mask for mailboxes owned by kern=
el (in
> > > essence what the IE register should be for the HSP shared interrupt o=
wned by
> > > the kernel) and serve only those mailboxes owned by kernel. Note that=
 there
> > > is no reset for HSP in Xavier, and the IE register contents may be st=
ale.
> > Would it be safe to clear all of the IE registers to 0 on driver probe?
> > I seem to remember trying to do that and getting similar behaviour to
> > what I describe above, namely that interrupts on the SPE weren't working
> > anymore. I concluded that the IE register must be shared between the
> > various processors, even though that's somewhat suprising given that
> > there is no way to synchronize accesses to those registers, so their
> > programming would be somewhat up to chance.
> >=20
> > Do you know any more about these registers? If they are indeed separate
> > for each processor, it should be fairly easy to keep track of the
> > mailboxes used by the kernel and process only those. Again I don't know
> > how exactly to distinguish between TX and RX mailboxes because they all
> > start out the same and only their use defines which direction they go.
> > Currently this works because we program them as consumers by default.
> > That means we enable the FULL interrupts but keep EMPTY interrupts
> > disabled until a message in transmitted on the mailbox, at which point
> > we enable the EMPTY interrupt. I suppose at that point we should also
> > disable the FULL interrupt, given the above discussion.
> >=20
> > > And lastly, if we want to support only Xavier and later, perhaps we s=
hould
> > > be more clear in the bindings? There are no mailbox-specific interrupt
> > > enable registers available on Parker and your design relies on them.
> > That was certainly not the intention. I thought I had seen the per-
> > mailbox interrupt enable registers also in Tegra186 documentation, but
> > after double-checking they're indeed not there. I don't think the driver
> > currently "relies" on them because it uses them in addition to the
> > HSP_IE registers. I suppose that accessing them might cause aborts on
> > Tegra186 if they don't exist, though.
> >=20
> > I'm not entirely clear on what the advantages are of using the per-
> > mailbox registers, or how they are supposed to be used. The existing
> > documentation doesn't really explain how these are supposed to be used
> > either, so I was mostly just going by trial and error.
> >=20
> > Do you know anything more on how to use these registers? I can easily
> > make them Tegra194 specific in the code, but if they're aren't any clear
> > advantages, it might just be easier to stick with HSP_IE programming
> > only.
> >=20
> > Thierry
>=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvXCBoACgkQ3SOs138+
s6G3oRAAvE4g09T6M+bcqTOHF42q9MRJO0z8Y6o1jeeoiZUWxDWi7iT8JZaJzG9j
cd4H6MDnVlRLn/Kvu8mTvOV+bzIYoSsYhUC/+FUBhdvy5DDbs2U9+fy2Ee6E0jHu
BolMQxfFXD+YT1TS2IllYBDmTyhvgczPg0K2AKX7CPFtz/7+XrGvl058sZiTZWbU
fUHBUkU6DTrHtRH5tHUfnrwBknlkACbKUmwH6YOE3Pq/rtkXXfbYdiRMu2akKts/
q5I4y25ar/H6y1Qdx8w7uz6Yrb4NigE5Guqs8ZIs5TRn7e9z3UnLNneIKIHkpUcQ
ko8g95dulzVqTQ4GKUHjX1+1BDMyW6b5w3O0KusQgACZSk539a6TxH2eE3FCaCy7
kPRaMTez4gPN2Zk+1EfzZFSp5y24RpWF5O9YTyKoT6NotGP/hpfM783vdqyc4YdX
nYc130K9sXHqVSye86JKgLAg071yaUDSHy5OOzM5Bhr+7igxEAqIA8iWocJX1Dpm
nIUvXq3xlZ5lhfYhBkmptZCpEZTl+S1qvd2jOf27BTOWOkIPNW2GjKng7FU3BpKS
9BD+vuFAtFu1RCF/8PJUDyyreMBmDXy+2aX7EZu8SU7T690kWDA2PMxXBFI57mfB
HwXrg9EWsfSGNSodt5fzAz+XxvR/HWZG9HD2ril/kasMdVIMoIg=
=whfE
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
