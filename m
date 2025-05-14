Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD627BF6D;
	Wed, 14 May 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252053; cv=none; b=GMy/kbjiCugUCe+kDSDJltMP5owv70hpZW6NjsnJWrrYmQotZfXALFJOr/OEXCoMjdif0bG6xyyXozcc3MWqXgSH0olHpzgQfLAdDK1VLHDL3dfY3KyLALy20uwQgDKTkP3aAbPvL212ij9G4980cEFbsLuC6LuIWlpjR5stJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252053; c=relaxed/simple;
	bh=IasqIfco0KI2oHpfu7+WTLz+ONATfQU+ZxgRTei8s6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnUshOnJmsKS3HLEpcCNEdAmeEyiR81badZ1secnZYoBUVN2UkeS9qEnC9qNm+7ns51gzqVnKJ5yY2XOyu/0V2mKWcJeY1baDt8ALRxsI6c7ZA7ROMQZyASdXnBWIRQBMUDvrJEFBbi6VuXmkRFyGway7jqeyF2/b/vcus422Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=BiIbPkBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTokmmmR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="BiIbPkBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTokmmmR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E447F25400ED;
	Wed, 14 May 2025 15:47:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 14 May 2025 15:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747252050; x=
	1747338450; bh=Mo4glBBoPr3rk+Zgq1/Mnlg5qBtmfLIU8lnf+sEYeWY=; b=B
	iIbPkBpP2/mODebq8YR9ajeI+3CrNGCpM8IEcerZvrmm+1Am52gZZsVm+xvnmHHj
	keR2r52p4EG9d1uvMLtUzoL3xMX8NtxEwxSNqJ5XUtvN63AIpXAexZkqUnrZjK7Y
	4eyyG0AlfBv01IJizcwQoL5VQZfQy7IMLmA1FIAS43CXDtO3B5Kscfz5XA6hZ3NN
	diM1II2m/oQP3xenKYTE97MLpi1XaC/2H8q4V4ZdXSBR/nRPbeVt9WFzkFyZ1mkW
	JPJMAFIyRswAL8o2oXFxexbUm2LQpAF9QGJTKfvuDfoGwub8xq79NYj83ILT0ZLI
	Ik2ZvoGVS1HfmWmFeqPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747252050; x=1747338450; bh=M
	o4glBBoPr3rk+Zgq1/Mnlg5qBtmfLIU8lnf+sEYeWY=; b=HTokmmmR8u/56tx2z
	StuYxgy/k3cQ2UYAkWUmhXRpjxxcRXrIBumCjUYqmabKDtH0vfSshiswyFqssKRB
	ZLZFnuWACuxQpyNMA04C8bFU6LXSwFPJh7O734BmZaxUbUfefFMHz9IItM59ZQkb
	mxXQOBxO+KjG1VOkiFEejlV4tugXMQEFioN20omrZh1gHJkGICBbhctiXHWjb8st
	j6lUzBtekyN7WaUN78DJUd+DAydNggnZpOVE8VxTQ0UXbKkxBGTAcXgeLelU2tGy
	xEnTdjjWk3dLBLloHH4Lnxw+3aHI6IWuy7YhYrCdOc2mKxMEH2ZvW7cS5m0TxZTT
	uG2hA==
X-ME-Sender: <xms:UvMkaNhaJDoG56LPc1hWO33dyoZGouNcMemmo5PFb80yIN_5_qXOTA>
    <xme:UvMkaCDaLsJCW2RgcaGtpFlMC-QBT26kKRloDjV3IbV63rAbDUaDNMGNkPYKmouFK
    BG0nwtUlvOuvnZq45U>
X-ME-Received: <xmr:UvMkaNH3y5LTk43uNNzsSaTYd5_LnMzqUq_Ru1TKBsltzrphFMx91uxzdtj_BSNGMTIHW0bvtAZoHdnvSgUrSfbKQsuEXkrnv6ftBvK4Xdn4j8f9HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:UvMkaCS2Dbn0FEpFjM6jqkoN9IJyEwtjdnzzLQ0FUj64Ow2zWMhpWw>
    <xmx:UvMkaKyp7nkTawVDY46EYUqdL537mFpZ19GSyJi7vr6bg4a0CoG0gQ>
    <xmx:UvMkaI5ihWoJmPVtkgVt8YvBZEkVTRaFZEu5JvbsuT189phWUmgKyA>
    <xmx:UvMkaPwb3KJw-ZtE3sBdwftBzsqrpB-uzoT_r-l4viApshfLbdM5rA>
    <xmx:UvMkaNh2fGq83cH9DFvMibqhPhGHKf8yNlHZXI2cx-sGvSPhKllaNafH>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 15:47:30 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A4DC311A26E9;
	Wed, 14 May 2025 15:47:29 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console size and cursor position
Date: Wed, 14 May 2025 15:42:40 -0400
Message-ID: <20250514194710.6709-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514194710.6709-1-nico@fluxnic.net>
References: <20250514194710.6709-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The console dimension and cursor position are available through the
/dev/vcsa interface already. However the /dev/vcsa header format uses
single-byte fields therefore those values are clamped to 255.

As surprizing as this may seem, some people do use 240-column 67-row
screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
close to the limit. Monitors with higher resolution are not uncommon
these days (3840x2160 producing a 480x135 character display) and it is
just a matter of time before someone with, say, a braille display using
the Linux VT console and BRLTTY on such a screen reports a bug about
missing and oddly misaligned screen content.

Let's add VT_GETCONSIZECSRPOS for the retrieval of console size and cursor
position without byte-sized limitations. The actual console size limit as
encoded in vt.c is 32767x32767 so using a short here is appropriate. Then
this can be used to get the cursor position when /dev/vcsa reports 255.

The screen dimension may already be obtained using TIOCGWINSZ and adding
the same information to VT_GETCONSIZECSRPOS might be redundant. However
applications that care about cursor position also care about display
size and having 2 separate system calls to obtain them separately is
wasteful. Also, the cursor position can be queried by writing "\e[6n" to
a tty and reading back the result but that may be done only by the actual
application using that tty and not a sideline observer.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt_ioctl.c | 16 ++++++++++++++++
 include/uapi/linux/vt.h   |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 4b91072f3a4e..83a3d49535e5 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -951,6 +951,22 @@ int vt_ioctl(struct tty_struct *tty,
 					(unsigned short __user *)arg);
 	case VT_WAITEVENT:
 		return vt_event_wait_ioctl((struct vt_event __user *)arg);
+
+	case VT_GETCONSIZECSRPOS:
+	{
+		struct vt_consizecsrpos concsr;
+
+		console_lock();
+		concsr.con_cols = vc->vc_cols;
+		concsr.con_rows = vc->vc_rows;
+		concsr.csr_col = vc->state.x;
+		concsr.csr_row = vc->state.y;
+		console_unlock();
+		if (copy_to_user(up, &concsr, sizeof(concsr)))
+			return -EFAULT;
+		return 0;
+	}
+
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index e9d39c48520a..e93c8910133b 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -84,4 +84,13 @@ struct vt_setactivate {
 
 #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
 
+struct vt_consizecsrpos {
+	unsigned short con_rows;	/* number of console rows */
+	unsigned short con_cols;	/* number of console columns */
+	unsigned short csr_row;		/* current cursor's row */
+	unsigned short csr_col;		/* current cursor's column */
+};
+
+#define VT_GETCONSIZECSRPOS 0x5610  /* get console size and cursor position */
+
 #endif /* _UAPI_LINUX_VT_H */
-- 
2.49.0

