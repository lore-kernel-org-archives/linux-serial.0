Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776311;
	b=Ko5VEYjo90xCljn0zoyayt0YYKG/5bXdV8a4e3Y9URYWTU1qDFwuDD5AZ9WzXssThuEy
	 Z0WjUswVmH1tZ/u4KCg8DCuL+ZvhAav/q55klRGeWY71uMj0SoBdUdXre6OdGOsPq6NWA
	 khA2k/1yFyLPlMTVugIM/C51H6HkKtL8PaAfGJA7+QIjz5UW+o043PxL3FxC5NKhjNtXC
	 pby4LpA4BKvs//e6aug4zMjZz5B4k+/Kxf0w9HHNGIiZLahd7+vBTWdZtg+WdrLU792g/
	 OdviXMkL/ECm98T5Gncp/TR2iCF2YDM/8HKz7FMEUGvuZ2pz8BnV2qk3WnNV/aJTvQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776311;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C8FR9IkzKysy9tR+7zpNLWvy1e8SpxoC73zYLWOTfmE=;
	b=UkprO18ROOtcY4BraxSIZZOE5/gv8NNJw/a6WcmntCVZH5UR1+HjdL2CTUfsHDU+L+pc
	 h0n0sFrqzlDFWYSxxMs/J7PvF+DCuEfYYB6SYc29l8oc3TYR1mU6LKIlhJ17yuiOuGf0C
	 K8QkAyA+ITtfHIOqM0Y+sjVE5O/TcTItItR//jGVU5xv8cBvGzQaHmVLlwRzOaS2xnhKl
	 ltxkqlZO/YBC68i6vWYCMthRDhag0lsCE0AclQpAzrtPA7VQhqJmM+38SjJB7O3fkfzC3
	 yWm/d5tp7Wk8fzmb2zv68fOVjueTYjQXo+waDDtkwMy9fmQMYSoARS8bq8chFKAlUDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPmL1HI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AF606A329
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPmL1HI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA64C1F00A18;
	Wed,  4 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776310;
	bh=C8FR9IkzKysy9tR+7zpNLWvy1e8SpxoC73zYLWOTfmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPmL1HI4PPlLmFP3Hyiv3F0EsBB+R5xc0x2h/p3zXNWxkXgPZwRGWfY7+IOlfAJtL
	 tcDnOZR8J7B9/lH8yen6UsOCtOrqF+PPmrqAC6XQPoBcUKUW4MULgRUcC+JAk/9H0s
	 iX34HjN7RfCZK+Lmq1Vd+GdaibrJxN4aAtHrHh/xjsFpUgaZt/LrOrEx9DvmOeURSu
	 FC7g0Fy/A7REJpqeq1wRN1GUiDIuwgXuRmBFx821o+uKMCkPu4HpoqHQCD1BfLRbCk
	 8ddr1Lj4GTpTT9CwtWRnQ8uyn6Q1NCJ7MLtfIlyJu+WosnbTxqDNLMNSAWfFL4JKR6
	 ldmjDWmoK+4rw==
Date: Wed, 4 Nov 2026 08:11:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: release the control channel if device
 registration fails
Message-ID: <20261104-ludicrous-heavy-kakapo-65e289@quoll>
References: <20261104021509.1468558-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104021509.1468558-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:15:09 +0000, Wentao Liang wrote:
> gsm_activate_mux() allocates the DLCI 0 control channel before
> registering the mux tty devices. If gsm_register_devices() fails, the
> function returns without dropping the reference held by gsm->dlci[0].
> 
> The mux is left in the dead state, so a later reconfiguration allocates
> a new control channel and overwrites gsm->dlci[0], leaking the previous
> one together with its tty port and fifo. Release the control channel on
> the error path.
> 
> Fixes: 734966043860 ("tty: n_gsm: fix resource allocation order in gsm_activate_mux()")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/n_gsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




