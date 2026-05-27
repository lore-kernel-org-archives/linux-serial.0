Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C763D9DD9;
	Wed, 27 May 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869932; cv=none; b=RcHp6Zn1SA1NxfLsUpGqFEwVWa7qcXJUybjBoM/nOmVYPwN59mKOz01UPLffKbcbURax/lhy27qkchD7z2/ERoorLyrVOStlLmkJl4/BpIlqh5cJWFLA4G1dRnMEPVGBGDUddW/Pz3z9lBPYe2iHYlbIvgKaBcUavedCDVFGeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869932; c=relaxed/simple;
	bh=CVKpheb20JCzJbhFR1pzSlUQ/xu/MvpZGqIeoPhNb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtuxjkk9Jc+3UbYPL01KN9U+0CyPqRnNa+WiDkwNLh5hWYR/SHMJEOA7SMxIeMEMia6Mc+aP3DdNKp+ClqSKyrwoMgP+zIRmowOiBwX/688iGVG98Z7Gkiue0DRAO63FUJApdAdTVmWYZI6D6VNlMKUElPIziVV8jWcGfh6bhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5zzBjLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5zzBjLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E81F00A3A;
	Wed, 27 May 2026 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869931;
	bh=awHDRniqmHoO6fJOKm0E623+DJHt/e27582zlx+wwro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=w5zzBjLRtLcXaM4guF40IABOK+PmJPAn5gSYhoAxgJNYYbWurFMr2KI+wy5L0C36/
	 8FOTGXPj+gCXz1wVj/a88vjdnIXQ+QjqTf5EufbRoE4/scOYnh6CaIUXxpN6asvtnK
	 a2f/aElveazZIykB/tYaRTjw+TzVlWDx5yJfmF/8=
Date: Wed, 27 May 2026 10:17:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com
Subject: Re: [PATCH v3 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Message-ID: <2026052738-unexpired-diligence-10f8@gregkh>
References: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-serial-v3-2-b4addb151376@oss.qualcomm.com>
 <2026052258-scrooge-friction-fe21@gregkh>
 <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>

On Tue, May 26, 2026 at 10:36:18AM +0530, Praveen Talari wrote:
> Hi
> 
> On 22-05-2026 15:17, Greg Kroah-Hartman wrote:
> > On Mon, May 18, 2026 at 11:26:56PM +0530, Praveen Talari wrote:
> > > Add tracing to the Qualcomm GENI serial driver to improve runtime
> > > observability.
> > > 
> > > Trace hooks are added at key points including termios and clock
> > > configuration, manual control get/set, interrupt handling, and data
> > > TX/RX paths.
> > > 
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> > > ---
> > > v2->v3:
> > > - Updated commit text(removed example as it was available on cover
> > >    letter).
> > > ---
> > >   drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
> > >   1 file changed, 23 insertions(+), 4 deletions(-)
> > This patch did not apply to my tree :(
> Do you mean these patches are not applied cleanly?

Yes.

> If yes, i will push on linux-next tip.

You mean rebase, right?

thanks,

greg k-h
