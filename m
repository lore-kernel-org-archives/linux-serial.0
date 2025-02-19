Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC31B85EC;
	Wed, 19 Feb 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956997; cv=none; b=V9fYF9Dm9XCS3CH54m0XTzN8pStu+VAoBfVEMKZb5Y+dhoIVKCYe4e3DC7nRBlK0thpTzQ60d1ALDn1Rm4R6cxLWUdhRXb2ubL2pj1XixRWkKef8Aun8yuqEpsgcnsL9gZUKwuNs18OabosWi1BL3HE1tkzvGC5UxulS901Bz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956997; c=relaxed/simple;
	bh=edDYdJ1koOY5vO64/PjG+7myObUD05yXqicg12hNyTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiS0ABXmVvDHzz3WSigKwe6tmI8SE2tAvSmNr6VaDsMNn8DLAuTMpwi9pSeUauCPGInkCgiBaAZskBj1FvxhoWRMNygnhhC6RfJj71V/DNt470q/4vwzlj7/4baOeSJA/S+Pso7RtCClNOl+qgaBlVfNgk7pJXxv6hFYE5XGHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f27tE3nY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f27tE3nY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C53C4CED1;
	Wed, 19 Feb 2025 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956996;
	bh=edDYdJ1koOY5vO64/PjG+7myObUD05yXqicg12hNyTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f27tE3nYzA0v/r8V4+mbWwUAUaUd+unL7IsUt089+1o9U8gVeGVx1XjYgsAxx9UQy
	 CarEWcnY+QDulSLTY9yxPUlOp+neTD4m1zuwQsfAfjY8iQ2yHGo2N9AyRnkC9Tsr8s
	 vA76eQXCcMbFdBk0TDh/nyj5AU4j9eCajorEXiMdUlcQrVOrZgAr2brr49iOjSYgNu
	 5CAzgneHUbJ2Ft2LhV3n/lXAu1wBkMBZKSZmaK6Zf29xqZMmsQLxw0Xb3N7rpHv1eH
	 hr72zqmqoBYcmUJc7MxUmBNpIzsaT2b6bZK6ZanQnitwtaB4ICruHY9RvYtxOdfEOk
	 FyEGtQRZci8cg==
Date: Wed, 19 Feb 2025 10:23:12 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/2] tty/vt: Use KVAL instead of use bit operation
Message-ID: <Z7WjABCTLE4CisKY@example.org>
References: <cover.1739881707.git.legion@kernel.org>
 <01ee8849ef8dc49c93a77bc4961ad56b9d435b8a.1739881707.git.legion@kernel.org>
 <3d96896d-5bb7-4ae5-a6c9-b586337eaa3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d96896d-5bb7-4ae5-a6c9-b586337eaa3f@kernel.org>

On Wed, Feb 19, 2025 at 07:24:52AM +0100, Jiri Slaby wrote:
> On 18. 02. 25, 13:29, Alexey Gladkov wrote:
> > The K_HANDLERS always gets KVAL as an argument. It is better to use the
> > KVAL macro itself instead of bit operation.
> > 
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >   drivers/tty/vt/keyboard.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index 804355da46f5..7df041ac4d5c 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -885,7 +885,7 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
> >   		if (kbd->kbdmode == VC_UNICODE)
> >   			to_utf8(vc, npadch_value);
> >   		else
> > -			put_queue(vc, npadch_value & 0xff);
> > +			put_queue(vc, KVAL(npadch_value));
> 
> While the mask is the same, this is not a kval, right?

I'm pretty sure it's KVAL, but to be honest I don't understand why it is
not done for to_utf8() as well. All values passed to to_utf8() must be
kval.

We call to_utf8() in k_unicode, fn_enter (through k_spec), handle_diacr
(through k_deadunicode or k_unicode). All K_HANDLERS take KVAL as value.

If I understand this code correctly, it is more correct to write it like
this:

--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -882,10 +882,11 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)

        /* kludge */
        if (up_flag && shift_state != old_state && npadch_active) {
+               u32 kval = KVAL(npadch_value);
                if (kbd->kbdmode == VC_UNICODE)
-                       to_utf8(vc, npadch_value);
+                       to_utf8(vc, kval);
                else
-                       put_queue(vc, npadch_value & 0xff);
+                       put_queue(vc, kval);
                npadch_active = false;
        }
 }

But I may be wrong because the code about npadch_value is very old and I
may be missing something.

> >   		npadch_active = false;
> >   	}
> >   }
> > @@ -1519,7 +1519,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
> >   	if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
> >   		return;
> >   
> > -	(*k_handler[type])(vc, keysym & 0xff, !down);
> > +	(*k_handler[type])(vc, KVAL(keysym), !down);
> 
> This makes sense.
> 
> -- 
> js
> suse labs
> 

-- 
Rgrds, legion

