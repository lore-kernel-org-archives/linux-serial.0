Received: from sonic314-15.consmr.mail.bf2.yahoo.com (sonic314-15.consmr.mail.bf2.yahoo.com [74.6.132.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA51A2550
	for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799374; cv=none; b=Ihw2Flo9jOsEXdPgtdb9LQk+3anWFx+s0z+Q5zKrCmhGnPGgIfB8AOmLGF+iEWnScVmqrlnH8Wb8fBiglKX71BugK+24F0ap6rrXLqoqBZqPQ4DTey49crSZZjhQC1Q/GncgSxbbYFfrd/KVDE8VWDdXFOKGgW6Bqv+Am8DseL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799374; c=relaxed/simple;
	bh=Ut09OgPUgiy2HyOPFjvTiH1TzeaxqLTi1OTZZFDBuOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkU3Eb65vjQ+/0kOgYFz1yheOxcQrie6s/KuieAoNY020xZCbvalcApoxey9v4cscDMOG4iUWmgGf25oW/S6+p3r782sVehcZ9GiJnsJRUDDClMvmgjD/VaXzrL+GJq1XYIVnTkgCyG6vigxZ8ZJjoZstf0anFLxAbqtE1yaaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=W4x1ACSy; arc=none smtp.client-ip=74.6.132.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="W4x1ACSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1733799364; bh=7u+p7x8vjrRolX1HYGYr0QM5WNuszNYs1v6i7tHEzkc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=W4x1ACSy1KnRmEUWNEN8qzyPRgGwgNV3fDAqTOPFAA3DJgRMfS/zD1JzpXlgsxRJRr/cJ+n6Uu0vSJsyCSJVbNhca8TcoX/huVGFfxQigdyJfEIDfaIiNYQa2vLP/E+vNPJSY5QFnGbasL3SGTG6bo8M2ACXTmDF353k22rBO8zoPeMzROJzQ2ZJGOYoWopsfiG+GSySj6PukfLlWXkVCJ0liqF6mUi7eweCyPNtjb5ohDg9Tobi4aaKVBIo6QUa9LjsLcURompL7Bg8CXYN9il8nG6dSsGSCi71IQy/ZjPXDyluUd831/j9xg+FoYEm6LWfywF5xgcwA3mD0ILgUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733799364; bh=q7OJIpLIRZqutc6AaCpCiiM3VxjSEtAc+kY8pZT2iTO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=toYdV61UBX++nDiyD+TlQ4r7x/QO4X/oPIX4n9BS48XTEExApGQQAatMLGSUSfMha/+Vj+PbL8gJOf/ecLN3IrScWD/WYMcs7qM6LAtYq2OMBv+BDbCdUwCpmV0nRC9JyxAV84f/3LhYYEa40YoOzg7+6qGQRHLRxNVvJ8k7cQmwZpZnoluFvfhybZa6oL85FV3IvH2wII6MTleHyEjL4Ypmr9VIi0Sp4a8v6wNf0+CLn7GKjLf352Su7/EI5tcxhbDS8HZL11l0JNKG/CM4FNea491pAeSSiBXHPdU/E/jJErm7FevwSUlBxoqbhVb+1DdC9UcMJjdUQCtiyknafQ==
X-YMail-OSG: sJuJEKUVM1mNEgclJ0gE7km4KLb3DcdS0TEzIz7xW90CEyfr81JarpBTa2Xb9KG
 kRGM9eEx8hbKJzZzrCj5QVmR3MVTUpaib8vD4jJ3vajOJgrdM5g_MhJR37L8AEi8EhV5fqekjT64
 XOp5ZhBuOpbF.wKfaq9bBbydCozxLdq8DIFF33akxHo0cBloywc4d7f67Oo5JxipjZc9QaUMg.qA
 nQPLolAYVmuJcNqYak7G8MAFoKSK9m13ajxlpNRccDuasWit_pMGmzdGfR8ms6uOtEo4uP42j6fy
 iuyeg4Wl2fvhC8Ktw6Oduge5XousOoP56u1GseJgM2ADYzW72QX4_FsO7fbWJbNi.6WLixE7HjKm
 RBTA6VimAKAYi1HuZmaegJd4rS7TKl_NzzmakIghAEkCS8_aTntEyRONWOIWeFWFdDnw9TNK5Pul
 jZHn_yl5AHngtJLt9oO1DxsUKwDZkKEPlbXs_TN0QfVPQj0xCiMs5ZRJgNHQWnpWkrgE9I.9sOAV
 yxceo38DIOAq80UsH2DK9WPEU9Yk0JFV3Go03eKYhcBbi8kgHUwe.vWqic8oZtDA563KCE_.XgzH
 A9m7g_du7PJbNjwbQSNSF6KaGDgrEWK7JuG4uodsYxYBjaUfJadl9Yqf0SwRNtb2PG_SqH0aHb95
 _oO.RUskulgFliuF9Nj6wQiCEudW4Q_Th92_N57oRWg.qdNFTnDW9sgnxhU5Gjj0z.ianzl1eHbj
 4vRVevDDPhLFCgm_RGc7653J8Na0XFXBXNhyc3GlD1wEDPFmYuvaBBW2ZN5W2kp6YHncFrravmir
 mxcNDS4zgokeFAm8mq.G0E.T1VO9LtroLgYfK6C6eLPnc9GulQMbnNyrxG.DX2gJd6CLebl.Wx4g
 FOZD1KZ6JtRqPtaKvcpI1D1zOeIU.kcL.9K9bnZPMEZ3rAp60x27qBQwDTnWPUHq1RymxtAwhTYu
 tWfDgAGgNORBa_ifhhn1ZMnXPd7hB74xWbBP6j47UAISlPai41vYt9aojmZCDPGOQdfhGpyWS04l
 iXEc4XUbwMVyNZJ_qLMTNmGTwU.Fuztv2WMGRBqvxAsnoOly7zkP0K9QkHFXGIKbOehMWATDhiVO
 akcK3s18ZQ1DcI5RcfkGYyvb6eAZxqaExsf8uHALjvMwgPdGmgYfR_RT3Vfu4FoTqqawarGWn19Q
 RUpzSRr4l2pV_pnPSF2fLBn3Zi_NRxZBJwiPoxOzWhlgB7eKlR3X5AsoakVZdRARwcMRSztNf9t2
 L53rhNd.yJblNVmkzL6uk3ZWfuFClefUnrGj7DYkb6XdeEhxCJVWgYywhxuF_x8VcFzmbY7rbB91
 zUnd0Gh8h5a9O.Q6LFjpDisSDE0xMkkypz.KpkdOFN5P9UF7rw5kgpRiej9x5H.JT.nnDyp6LWm0
 FeNYpL1dpFiSvZIONQ4D1GXCeuRdF871ueYWaDBOVgYbcElmXSUqMDSBonYmShXrs8etBPW0o5pj
 2CAp4hdazZpum6ga0wOk5oFxEY8euKQIDs5ifZU.aLEMnRUwqFQxPBcGCwFQe0CzAuv._YR7RyBC
 v8BQ4eGsLyuLgVRYMHdsst_kXerF5O8ztPwGqpmCyTAxh8N.BWrL5IYbuaP.HMd3hwci7aK3t3xv
 WPEcwb2d08VdRshFx2GaindxBBvtZfl0FlJIWT00uclHilBXggPWFNPYgrcVfEpk1O5.GvNq8fMs
 1m1nC1c2GXWO5EWExKq31yR7kHd5p9sL8RF2g2fweL7B2SgFLIWgHWu4xiJEfAon6gNiucAyJ7O3
 _tbER5bEHDKjbBK6.Ig_PfDymAHa8xCMgtzsZO6amQksDGOSbdwtaMpBr48Lq65I2TlUaVcZQqmY
 Cco0AfpMqE59hD2YYD_3UPcpiObl03FpBDeYC9UumsLQx8_QyhBE1Ydx2JpXJvKTebf11gCmJsZZ
 XeKti_Wh2xKn41V5weKrpc3BB0505LuGLB7EHgVqN.WraEL0ytg8FHuczJ91EPIOZvLl5BV5uqgA
 2Wz2wm0fVHCsuLFPuxyAd7ciGHLi3WihK_AV54Udpq5pcqInq8G961.DauhOSod4oMV_gr302L9v
 Xya3yCcAY1Zt5_oaKIX5EnHmA96DiJzLERdSXDCiY7VBhHkLXqfXJIDXT73ewZVoZk9FEt1Ai5RU
 sC6cBWi7yoyV5Zv18qH0Eiwlj6vTLvUSPRdpiz6PwHusjIS6M2San1v_G1WXwZnVMCw5RX2Pog2O
 O580Nd0fRrScylOOHLkyvcReysbrhHPkHPphJFz3RNxw5x17YBYDSgqSyEw--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: e5b77a78-8771-4efd-8124-75a967a7330d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 10 Dec 2024 02:56:04 +0000
Received: by hermes--production-bf1-66bb576cbb-swjjv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14a765989d113f920c1732c31ededbff;
          Tue, 10 Dec 2024 02:56:02 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Mon, 09 Dec 2024 21:56:01 -0500
Message-ID: <2682057.tIAgqjz4sF@nerdopolis2>
In-Reply-To: <2024120911-daylight-feminist-a1e1@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <2959951.SvYEEZNnvj@nerdopolis2> <2024120911-daylight-feminist-a1e1@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Monday, December 9, 2024 1:35:04 AM EST Greg Kroah-Hartman wrote:
> On Sun, Dec 08, 2024 at 09:16:28PM -0500, n3rdopolis wrote:
> > On Sunday, December 8, 2024 8:30:08 AM EST Greg Kroah-Hartman wrote:
> > > On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> > > > On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > > > > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > > > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > > > > device.
> > > > > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > > > > 
> > > > > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > > > > reviewing them), until that happens.
> > > > > > > > > > 
> > > > > > > > > Oh, I thought that I didn't need a real name
> > > > > > > > > 
> > > > > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > > > > 
> > > > > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > > > > this signed-off-by you used here does not meet this category.
> > > > > > > > 
> > > > > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > > > > GitLab name
> > > > > > > 
> > > > > > What if I made the signed-off-by (and committer name) this email address? would
> > > > > > that work?
> > > > > 
> > > > > Do you sign documents with your bank with an email address in the line
> > > > > that says "name"?
> > > > > 
> > > > No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> > > > doesn't work If I really have to, can it just be my first name, instead of my
> > > > full name if it comes down to it?
> > > 
> > > No.
> > > 
> > 
> > Can I do first name, last initial? Or does it have to be a full name?
> 
> Honestly, based on this long discussion, I really don't think we can
> take any contribution from you without having someone else verify that
> the the name you use here is correct.  Please work with the kernel.org
> ring-of-trust to get a valid signature added to it and then I'll be glad
> to reconsider.
> 
> And note, I'm not singling you out at all, we have recently had to do
> this for many new contributors.
> 
> thanks,
> 
> greg k-h
> 
Understood, and I am sorry, I am trying to go though kernel.org to see,
do you mean asking helpdesk@kernel.org ? I tried reading the documentation, but
maybe I did not look in the right place


