Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F141BA61
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858086; cv=none; b=WVKYMAAqHpccefzon2tbRrWAfWUTPBDjgrkpEjjppOEowK4uiXive1INWRleKBtwtKylE843sFYlm9CJUAuzBbeMO6TRZxt68+sv3xslSXL+W8W6sbMhBBW6Jb6G1J/eLfHFwFGBWjJLboHSoRl3wrcP3agyhVpF0yu/cDixZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858086; c=relaxed/simple;
	bh=V1lm998MAVKnCC20xCmPz7RgC4oPMFkEgoAARoiBCRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1viCLeYGYxV/xb4F8Pv866FM2G6/mid64Vr5yEWGrBiGVVDPTXzCb1iKGg19bReO36rv0TqLJzzCmoU6Z/NT6fsF0DvH56UBkVUSLpwWnxLimJN8Mu6HkcSlCpdGsyHj5o0GOCs8BSYaRvDY/WuEVAoVBA0UWNDhcyFEvGNqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otr70YW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otr70YW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6011F000E9;
	Thu, 27 Aug 2026 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858085;
	bh=4MCcPLQwAYcAUcomGDzjnRCJvRi8JKh3hfPF9OXSFyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Otr70YW4fAWHUpHuicXE8sba3RQFdhuqqmz2hdQpLf/ms1v3bH9aWKtcrZqOD6E6N
	 t9mWJ7CKLufYcXnnCgZ94ZR4+I22/Roeta8skYydX7KSLmr//4fDO+T/aRggu2kLmw
	 XjS8KixZAJX2cPNF4z0I82oeoI2v/HDT+HwGKAqPIiC/ygoYr5Um3y3qWrhjg2Q+5Y
	 l8zcgJvjgiBiQnrK3hQomJWwKB9f150kDi15M/z8iJdruS8bO9+kZG5Eg1gAm7keq4
	 6MiqKfWwPNlIlHGer4Jemln2B0YYZCL41x8/R4qAnq+/pJDIpDUFJyQVYbAXsAuTE6
	 lCXXiLXHDvt9w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 1/9]: Make consolemap.c handle Unicode planes outside
 BMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCFLI0ga-DG-HRN@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCFLI0ga-DG-HRN@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:14:44 +0000
Message-Id: <20260827191445.0A6011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Use-After-Free window during active dictionary reallocation fo=
r inverse translation maps.
- [High] Unicode characters >=3D 512 are incorrectly rejected in conv_uni_t=
o_pc when CONFIG_FB_GLYPH_21BIT is disabled.
- [High] dict->count is misused as the maximum font glyph index, is uniniti=
alized for default maps, and causes functional breakage.
- [Medium] Empty glyph slots are incorrectly copied due to C integer promot=
ion in con_unshare_unimap when using 16-bit values.
- [Medium] Incorrect allocation size calculation wastes memory for user-con=
trolled allocations.
- [Low] Label at the end of a compound statement without a trailing null st=
atement causes a build failure.

Pre-existing issues:
- [Critical] Concurrent read UAF in con_unshare_unimap error path.
--

commit 58f6de25804fcafcee92f219003205102885c384
Author: Alan Mackenzie <acm@muc.de>

vt: 32b glyph: 1. Make consolemap.c handle Unicode planes outside BMP

This commit adds a fourth layer to the sparse map in consolemap.c to handle
Unicode planes outside the Basic Multilingual Plane (BMP). It increases the
supported glyph number limit up to 2^21 and shifts user-to-kernel data
conversions to vt_ioctl.c.

> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 3fa89a2dbebab..2f695d97f0ebd 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
[ ... ]
> @@ -235,23 +248,22 @@ static void set_inverse_transl(struct vc_data *conp=
, struct uni_pagedict *dict,
>  {
[ ... ]
> -	if (!inv) {
> -		inv =3D dict->inverse_translations[m] =3D kmalloc(MAX_GLYPH,
> -				GFP_KERNEL);
> -		if (!inv)
> -			return;
> -	}
> -	memset(inv, 0, MAX_GLYPH);
> +	kfree(inv);
> +	inv =3D dict->inverse_translations[m] =3D
> +		kmalloc(dict->count * (sizeof(*t)), GFP_KERNEL);

[Severity: Critical]
Does this create a Use-After-Free window? Since GFP_KERNEL allocations can=
=20
sleep, freeing the active dictionary array and leaving the pointer populate=
d=20
before the reallocation completes might expose freed memory to concurrent=20
lockless readers (like accessibility driver keyboard handlers) calling=20
inverse_translate().

[Severity: Medium]
Also, does this calculation allocate more memory than intended? inv is an=20
unsigned char pointer, but the allocation uses sizeof(*t) where t is a=20
u1632 pointer. This allocates 2-4x the needed size for 8-bit inverse maps=20
based on a user-controlled element count.

> +	if (!inv)
> +		return;
> +	memset(inv, 0, dict->count * (sizeof(*t)));
[ ... ]
> @@ -252,39 +265,48 @@ static void set_inverse_transl(struct vc_data *conp=
, struct uni_pagedict *dict,
>  static void set_inverse_trans_unicode(struct uni_pagedict *dict)
>  {
[ ... ]
> -	if (!inv) {
> -		inv =3D dict->inverse_trans_unicode =3D kmalloc_array(MAX_GLYPH,
> -				sizeof(*inv), GFP_KERNEL);
> -		if (!inv)
> -			return;
> -	}
> -	memset(inv, 0, MAX_GLYPH * sizeof(*inv));
> +	kfree(inv);
> +	inv =3D dict->inverse_trans_unicode =3D
> +		kmalloc_array(dict->count, sizeof(*inv), GFP_KERNEL);

[Severity: Critical]
Similar to the 8-bit inverse translation map above, could this expose a fre=
ed
pointer to concurrent readers while waiting on the GFP_KERNEL allocation?

> +	if (!inv)
> +		return;
> +	memset(inv, 0, dict->count * sizeof(*inv));
[ ... ]
> @@ -297,18 +319,19 @@ unsigned short *set_translate(enum translation_map =
m, struct vc_data *vc)
>   *    was active.
>   * Still, it is now possible to a certain extent to cut and paste non-AS=
CII.
>   */
> -u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_un=
icode)
> +u1632 inverse_translate(const struct vc_data *conp, u1632 glyph,
> +			bool use_unicode)
>  {
>  	struct uni_pagedict *p;
>  	enum translation_map m;
> =20
> -	if (glyph >=3D MAX_GLYPH)
> -		return 0;
> -
>  	p =3D *conp->uni_pagedict_loc;
>  	if (!p)
>  		return glyph;
> =20
> +	if (glyph >=3D p->count)
> +		return 0;

[Severity: High]
Is p->count the correct upper boundary for a font index here? dict->count=20
is initialized to the number of user-provided mapping pairs, which might be=
=20
much smaller than the highest glyph index in the font. This seems like it=20
will falsely reject valid glyphs.

Furthermore, looking at con_set_default_unimap() (not modified here but=20
impacted), dict->count is never initialized to 256 for default maps, leavin=
g=20
it at 0. Won't this break reverse translations for default fonts entirely?

> +
>  	if (use_unicode) {
>  		if (!p->inverse_trans_unicode)
>  			return glyph;
[ ... ]
> @@ -587,63 +639,70 @@ static struct uni_pagedict *con_unshare_unimap(stru=
ct vc_data *vc,
[ ... ]
> +				for (g =3D 0; g < UNI_ROW_GLYPHS; g++, uni++) {
> +					if (row[g] =3D=3D ~0)
> +						continue;

[Severity: Medium]
Will this optimization check fail when CONFIG_FB_GLYPH_21BIT is disabled?=20
In that configuration, u1632 is a 16-bit unsigned integer. Due to C integer=
=20
promotion, 0xFFFF is zero-extended to 65535, which does not equal the=20
signed int -1.=20

It looks like this will result in all uninitialized empty slots being copie=
d=20
via con_insert_unipair(), wasting memory and corrupting dict->sum by=20
adding 0xFFFF for each empty slot.

> +					/*
> +					 * Found one, copy entry for unicode
> +					 * uni with fontpos value row[g].
> +					 */
> +					ret =3D con_insert_unipair(new, uni,
> +								 row[g]);
> +					if (ret) {
> +						old->refcount++;
> +						*vc->uni_pagedict_loc =3D old;
> +						con_release_unimap(new);
> +						kfree(new);

[Severity: Critical]
This is a pre-existing issue, but does this error path leave a dangling=20
pointer? The new dictionary was already published to readers globally via=20
*vc->uni_pagedict_loc =3D new inside con_allocate_new(). Freeing the new=20
dict here could cause a Use-After-Free for concurrent lockless readers.

> +						return ERR_PTR(ret);
> +					}
>  				}
>  			}
>  		}
>  	}
> -
>  	return new;
>  }
> =20
> -int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user =
*list)
> +int con_set_unimap(struct vc_data *vc, u32 ct, struct unipair8_21 *list)
>  {
[ ... ]
> @@ -660,7 +719,9 @@ int con_set_unimap(struct vc_data *vc, ushort ct, str=
uct unipair __user *list)
>  	/*
>  	 * Insert user specified unicode pairs into new table.
>  	 */
> -	for (plist =3D unilist; ct; ct--, plist++) {
> +	err =3D 0;
> +	dict->count =3D ct;
> +	for (plist =3D list; ct; ct--, plist++) {

[Severity: High]
As mentioned above, assigning ct to dict->count seems to mistakenly track=20
the total number of user map entries instead of the maximum glyph index, wh=
ich=20
breaks subsequent boundary checks.

>  		int err1 =3D con_insert_unipair(dict, plist->unicode, plist->fontpos);
>  		if (err1)
>  			err =3D err1;
[ ... ]
> @@ -769,54 +830,69 @@ EXPORT_SYMBOL(con_copy_unimap);
>   *	Read the console unicode data for this console. Called from the ioctl
>   *	handlers.
>   */
> -int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
> -		struct unipair __user *list)
> +int con_get_unimap(struct vc_data *vc, u32 ct, u1632 *uct,
> +		   struct unipair8_21 *list)
>  {
[ ... ]
> +					for (g =3D 0; g < UNI_ROW_GLYPHS; g++, row++) {
> +						if (*row >=3D dict->count)
> +							continue;

[Severity: High]
Does this drop valid unicode mappings when reading back the unimap? If *row=
=20
is a valid glyph index larger than the total number of mapping pairs=20
(dict->count), it seems it will be skipped entirely.

> -					if (ect < ct) {
> -						unilist[ect].unicode =3D UNI(d, r, g);
> -						unilist[ect].fontpos =3D *row;
> +						if (ect < ct) {
> +#ifndef CONFIG_FB_GLYPH_21BIT
> +							if ((p || *row > 0xffff)) {
> +								ret =3D -EINVAL;
> +								goto unlock;
> +							}
> +#endif
> +							if (list) {
> +								list[ect].unicode =3D UNI(p, d, r, g);
> +								list[ect].fontpos =3D *row;
> +							}
> +						}
> +						ect++;
>  					}
> -					ect++;
>  				}
>  			}
>  		}
> +#ifndef CONFIG_FB_GLYPH_21BIT
> +unlock:
> +#endif
>  	}

[Severity: Low]
When CONFIG_FB_GLYPH_21BIT is disabled, will this label at the end of the=20
compound statement cause a build failure? Older or strict C compilers requi=
re=20
a trailing empty statement (like a semicolon) after a label that sits right=
=20
before a closing brace.

> -
> -	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
> -		return -EFAULT;
> -	if (put_user(ect, uct))
> -		return -EFAULT;
> -	if (ect > ct)
> -		return -ENOMEM;
> -
> -	return 0;
> +	*uct =3D ect;
[ ... ]
> @@ -849,26 +925,33 @@ int conv_uni_to_8bit(u32 uni)
>  int conv_uni_to_pc(struct vc_data *conp, long ucs)
>  {
>  	struct uni_pagedict *dict;
> -	u16 **dir, *row, glyph;
> +	u1632 ***plane, **dir, *row, glyph;
> =20
> -	/* Only 16-bit codes supported at this time */
> -	if (ucs > 0xffff)
> -		return -4;		/* Not found */
> +	if (ucs >=3D MAX_GLYPH)
> +		return -4;	/* Not found */

[Severity: High]
Does this improperly restrict valid Unicode code points when=20
CONFIG_FB_GLYPH_21BIT is disabled? MAX_GLYPH resolves to 512 in that=20
configuration.=20

This validation replaces the old ucs > 0xffff boundary check. Valid Unicode=
=20
code points (like Cyrillic, Greek, or Arabic) that are numerically greater=
=20
than 512 appear to be erroneously rejected here, breaking console text=20
rendering for non-Latin alphabets.

>  	else if (ucs < 0x20)
>  		return -1;		/* Not a printable character */
> +	else if (ucs =3D=3D 0xfeff || (ucs >=3D 0x200b && ucs <=3D 0x200f))
> +		return -2;			/* Zero-width space */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D1
