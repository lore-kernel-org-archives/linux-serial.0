Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D539D6DA;
	Thu, 13 Aug 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663211; cv=none; b=NZLxWAKSG6dUPaKZwSGKPzveV4CMDWI7CwqE87kpbUGsOpSihYy8HlVrCnxAIH9wB374yeAOsxPtzU39PdME88DFXyL/MZsJrH2Geq2AqRfz1xmspXzYz2K8c3yHjE75GYIlM/uFO6p1pOQHo0gyOlspyv1u4AzRBLNy6yOPMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663211; c=relaxed/simple;
	bh=cnhS01uG9VWMhmA0DHTk2JdLGF1m9f/uYmZuCbHuVFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TivKh410XsozpiC5TY7DcVl96FSJ/Wnk8q77l+xY1mEs4jrDXa+Ze1EqKg5fZErQhhnqjCgRXeDUvJZXbrzfNFB+juZj8yn8AANfu6AX3j5lGlHNlJR1n1VVA5CeT4nes3aX0LzOFrgUcy1jfXhWQh4XFkQO5e4+zW/zCJaCUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw7C3vC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw7C3vC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155161F000E9;
	Thu, 13 Aug 2026 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663210;
	bh=iilT7T5vjN7wnf+WuVuEr4UAw0PHQT2Q1HqYsDLvtYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dw7C3vC0ooh9NFiMt16OJS5l21zmuw+HT3oCkEhK8mZX0Vhli6SPBlTepR6oQtw2R
	 iVDX0//YQjrJINad0SiLxk/8gtheu0/hvuUK4HaK4zXmuN8f3j27mUtZGNx8ijD0/h
	 rMw4Mrzh1X0c3q70TyQ3aZmc9F+asJEI9GyEdkocAYaQVJzZBGmbQCDFim/CMgd6Ev
	 zpP3O9SXPYQYQzJk7v6GZ8qzQ80eUsREEyqeco1e1XSIL4ZGFbuyS8EJHk+xArVDhD
	 r61rxN4dN3qCy6fhZ+9xq5iVTpXT9gEW1hg/fOj6iR4aw4jVU+dOgVlZdIf3snmIEi
	 kmv6gd5+07E4w==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field access
Date: Fri, 14 Aug 2026 01:20:03 +0200
Message-ID: <20260813232003.792467-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813152444.514580-1-dakr@kernel.org>
References: <20260813152444.514580-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 17:24:41 +0200, Danilo Krummrich wrote:
> [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field access

Applied, thanks!

  Branch: driver-core-next
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: serdev: use ThisModule::as_ptr() instead of field access
      commit: ddca0cd80096

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
