Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A64BA3D
	for <linux-serial@vger.kernel.org>; Sat, 28 Dec 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735347002; cv=none; b=Hgg7YcAdLbp/9FI6tLHgDgRk6UVeThgcm+JC4Qesg3KNvs2HzL+mDgJBWbPzHBLQ2LiBd9MZvTpHZy6aRvrYaOjPl8BGgg3k4TSUU+k/cPSkPuYIWvJ5M78XreFYRskrwfxJcR4/6E91BnOdgi1TTwmNJT8YWyBuH2nAushEMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735347002; c=relaxed/simple;
	bh=4PRfQXMSIAiKu2aQjmoR0pR8Zb2EkQIgVepoqRPCyIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGJYDJlC949vZUZpHj8Ikbt8ohXP7ZSNoZPviRk2ZHgpo2QnStqt2RzvA7DfOpgBa/7xRs3bWiuaiB175pH9DUqvhxorAFP5YdKU6D7gBWZBo3NIKzCp1d9rEizUaKRv5P1dtlaS/n+CNInteTyvpVxyqDxPaOk/nd1lxe+/z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=A8+xtWdB; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="A8+xtWdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1735346999; bh=RKbYCKl1m/9k00vtLGfjJI6qws7R7dclRWUPmBVGVsA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=A8+xtWdBWimarQCBfnXG12O8vyEH8PMdjxJfh/LQsm7mgGigZJl9Srmm5S3SySI1ffqPduJUVA2pzT862zuUwHyaQ1xeoPkbKxLVaEUE1fTgaN0FfByu1kksBIECuZ8wDhM9hviqHoqYtG0ouP1uGustKomtMWPr9TBnd7JScmZG/ldOZPT2jiEVkS5Cr5lQVGrWBDDNkmcp8ddHSsIIdgj9pWDuqTEX/Q9kRKg+thUSF1yDBVluvi9nZbVxwNF0lsLhP7qBtEYdv2rglkzKbh8/HUxC7gffw2hRjzS2wa3TDIrb6Zt875weP4Cp6i9fKe0LF9tMRLY0UF5xdswKdA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735346999; bh=AuTa0iv6x5fWC1BHGvlrikKIo1qNDpShCTMguJekB7d=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mZcrCaSt5jkylLlwnpS+8tXR05Rbtu/gUPGWIJ6jf6VDdkd+HhliQmIVtFSUomX5WAND5kdO9woTCYHACOV6/iY9qnxJaAL2pft4meHrEJn9O1zU75jr4vnLTC5XW79ZL2cWxmkZNLvbwbGkAaeE7PowEW8xjt3RcmyzRm2NJhNWsKAW6yCM00b6TKi7/C6OBCOhdg47+Vved5/FCmvNVVIizb9OyN6icFeEmxI4M9E32Q+9Eu1qJZ5C/DgTtCYFGkkf5vD5iR/LksmY+E60pUwozYRr8MNHnYTZGZKHBDf4D2uWClr0187GcAv5La8Te5zYxAQzIA75amhhmitGqw==
X-YMail-OSG: cLxQQU0VM1n4BCo7c4vufBl9QwHLXc3LH_4gbbDiuWYTuotk7NKMmg7EBIjseK3
 mNt0khOizUxlZdkGF7EUk1JT7AsWrY7aZANqK9DxwtvEcRMWIKMAzXHHjwb0O1RKIX58q.fkvEB7
 Vt9nXIaxU4OpVhCk31MfDsZRnZguXyNJNMOzohQunBeKM47qlWlA9Nd_Ellmr5GFfy6oUDK.J1p4
 89yiTEF9f_Ab5Z8H0xh.atslKED7nT4BwXydYouiIDxKd8WAh39qqD6CTqz0_KC6pag7M9rjxB6X
 TRbd_mb5zdZrkVqmEg61jPktwGuBO.lKyBL70d9rFsd00bmr2XFnrkIR3skME.Jly5B2BFPlEFS4
 fug_0E_6GC4cjYC3EQTlSxyW2PHT.EdqDOsuNOd6Ax1MauNWjlacDdWy8R9SC8Q_mPKJ7GnAU3xA
 z93Il5JnBThzd4Uw8_BCX4XhAF2jDKbfV47AlUFxBHdzwWnj0bO8VdDKDhkVHOsC75eQIP4_3Eiw
 DJh1Zhqqj6jfbaPSa4XxYiKpu2HIuUFtk6UOG1egsICewDar3suogFGRxB.qX04bQiL8eDuKhR1T
 ljjA_k5TMFQ2wyJoVp7RX1h6Dd2SQvgb5lrvyYTuKKXzsEJa6QxJVbIwvlr7ze8rN_fIfxTfVcFx
 lLekcKF.gADC2g34.Bf60LnwE9U5SV0vKVgeamtwfCaggLIOF.tNH9Aw7wfALIdZKX6GPTdqtqAG
 XaVw4JyD5rqKw9rDKQg6fL0t_CQVwTDjXsY8nAXMbEtzO05gNBRieqs6ZsarJWdd4h6TW1RO0R5U
 Ac9Terki8R3S7lv_xQvX8ckcGme4lrjfNOPZZtW4Dq6580GCFbMpDlys7vXcVOZI1QAQvEvuBisr
 J36GV1dOSwG305Nki84ncHC9up99lSeo_Zxb6WYxX5bnmZjDvtNg9.9TJePe2khW5wi1PaKppvXa
 Ng6T2JFd3Ht84jC_0_avLRKXffRFaUxfCrL7MM5xbqrXzLEfusQo89dT.nJUP6_dV.fAQzBJTA.P
 UTMVj02YUqNJZBG2jsm1QSGrG0TgK.WtfWzX3QT_7IF_BLfevNrYUo8oADUO6iEyuWVTT_mIBibN
 0HnCdixhgXtJlHPzGMehachMo_JIEa4mbh8Gf9Egbc5zYGTm2Ta9BQFqeo_fuCG5xs75Tg9CI342
 ssHTLLElAwUjaDw0YqMfG6SuIN0k9_pesI_ikHiPvJf4kFAbb2JnL8_O_yC.kRPvtfC9ASkKW61P
 MBmIc0IUz3Gk3WzIbYxrZUHr1bfg9ghGnJVUlPd.ewqyR.kqG2BazPbaBxSTyQXhiEL18R0zZrCI
 a4CecmHphkFYQ6r0YIlMbIBRrdRQJ1YyIm6tjlDbOetO_9RFpnC0xnWLT52DvUfofw7ddsbzRz1q
 _j9FV4MzEf3gVU6aiiKrU66c2F9LQuOuD6CuuopnyV3BQmhryfw0OkrtSR5zf4nUGj1jelADxsnO
 tljM4B157eFur1etWdVWod3_bohneCBcPc_9ZJIgsp6VVrx7haf0frg6RaMa6ejRlwuFPOyAEFMH
 kGjkhGtIPwQYeoqVNruDbAjSfpAnZG20wcOVvMIlGynOVuMeydU4NJ5lb.aqWV2q8sU6BwOgpPJH
 Zog9.gWsrmlWPdbyLI0rqSBcB6kmpsvh17uxFD9B9Iq13qATYAh1rQs73GzqoJ2BIEC5zud0qt55
 jutlU6jcT9Tq4so7SU1r2hUdqw2TFdHBKyzLihmanZbDdzUgglqw30UjKALCBpOIHK6b1MdjJvIk
 LV5ac0dsCKSqbzbx2TAUAFbmBbFZiS2VU1yHB.mPI32tOIySwzoyvR9EHQSFeGvS.eXT_CKOoJI5
 0wMa7_4GCbDvWxb7OA4l_Ykc_f.9AxEIHkXGYQ5hpsQ5jYg.HtR1MUS5aHeKvqa.B82WRZpgUy_i
 1vTWFAQCGqAGh0MquWDGVkJxLbgr1kwcqakvmHf2tDHkL7W80pizFvDZvWvSthjc6gYuspMKIPwi
 YDM_XcIfQ2ZBfW9wUhByV90tnOjxWezrbBS1bAzQ_iCNv500kkcS8lAiwrDCL3FOLa_H5NDuiBLC
 VJENqtnHwJ22K7.oKvtK5Ax_.lxG_dQlYLihMtnmS6IqPgozloI.72aPCHhc3IC.FwI0K3Z1H3L_
 bWbCp8w_WF9_jpMYqbctdb1TJaJYhVjQ2F6SmLCDu4fwTch1AGnMROpTeivvZ479XUblLOW2VhAv
 6qg66UzbVB9Y8NzN0cj3XIWhgMbax7excapi2Oqc3_9rDOEzvPzgcHQdh
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 7b53f4ab-4900-48ad-a07f-ec82a4dbf513
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sat, 28 Dec 2024 00:49:59 +0000
Received: by hermes--production-bf1-66bb576cbb-rzvf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bf43aeadb212612e72c5c66e49797472;
          Sat, 28 Dec 2024 00:29:40 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Fri, 27 Dec 2024 19:29:39 -0500
Message-ID: <6116813.UjTJXf6HLC@nerdopolis2>
In-Reply-To: <2024121006-womb-outgoing-a4b6@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <2682057.tIAgqjz4sF@nerdopolis2> <2024121006-womb-outgoing-a4b6@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tuesday, December 10, 2024 2:28:12 AM EST Greg Kroah-Hartman wrote:
> On Mon, Dec 09, 2024 at 09:56:01PM -0500, nerdopolis wrote:
> > On Monday, December 9, 2024 1:35:04 AM EST Greg Kroah-Hartman wrote:
> > > On Sun, Dec 08, 2024 at 09:16:28PM -0500, n3rdopolis wrote:
> > > > On Sunday, December 8, 2024 8:30:08 AM EST Greg Kroah-Hartman wrote:
> > > > > On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> > > > > > On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > > > > > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > > > > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > > > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > > > > > > device.
> > > > > > > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > > > > > > 
> > > > > > > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > > > > > > reviewing them), until that happens.
> > > > > > > > > > > > 
> > > > > > > > > > > Oh, I thought that I didn't need a real name
> > > > > > > > > > > 
> > > > > > > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > > > > > > 
> > > > > > > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > > > > > > this signed-off-by you used here does not meet this category.
> > > > > > > > > > 
> > > > > > > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > > > > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > > > > > > GitLab name
> > > > > > > > > 
> > > > > > > > What if I made the signed-off-by (and committer name) this email address? would
> > > > > > > > that work?
> > > > > > > 
> > > > > > > Do you sign documents with your bank with an email address in the line
> > > > > > > that says "name"?
> > > > > > > 
> > > > > > No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> > > > > > doesn't work If I really have to, can it just be my first name, instead of my
> > > > > > full name if it comes down to it?
> > > > > 
> > > > > No.
> > > > > 
> > > > 
> > > > Can I do first name, last initial? Or does it have to be a full name?
> > > 
> > > Honestly, based on this long discussion, I really don't think we can
> > > take any contribution from you without having someone else verify that
> > > the the name you use here is correct.  Please work with the kernel.org
> > > ring-of-trust to get a valid signature added to it and then I'll be glad
> > > to reconsider.
> > > 
> > > And note, I'm not singling you out at all, we have recently had to do
> > > this for many new contributors.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > Understood, and I am sorry, I am trying to go though kernel.org to see,
> > do you mean asking helpdesk@kernel.org ? I tried reading the documentation, but
> > maybe I did not look in the right place
> 
> https://korg.docs.kernel.org/pgpkeys.html should help out
> 
OK, do you think it's possible for me to get this in with like a surrogate or
something? It might be quicker for someone to get it for me with more trust. I
guess I will be willing to just be in with written-by or tested-by or something... 



