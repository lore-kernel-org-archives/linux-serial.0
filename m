Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6348359A65;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313151; cv=none; b=Wc+2/mljGz8VpewVCR2a4A+MWHwK9G6DU15l467M1pd3IxDYnuDjk868Vmh+iOfZDp+Qc1DFdjTXTuefbvc3tdBUT1hPhlqgp2IpTrtL6fScSUtesWXrMQEnGWpdC3qU7CVhJxNDZ+dSkPYYZDg5GD1lG4gpgbtdQj1pGBprpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313151; c=relaxed/simple;
	bh=0ud1QnU6DSZTrgik1DuQ8GzbwSpCgKyutvxo4R3s3/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh9AkAPxbc2fO8wBpyFGoJDVFcnGf5BQovxEQiajNvo/DXMLwBTbQojKefj31AGZPG7xrwKuN9d3dEhvxRSfWO4JWH95nMyMo7PAsd5rJD+3CV9m4v9YabiG1b1y3FoAnSPdhlI21bNKodPnGWmIpjx3G/CBAEpT28u3nN50e74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vuo2Oh+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuo2Oh+V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FB9C2BCB7;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313151;
	bh=0ud1QnU6DSZTrgik1DuQ8GzbwSpCgKyutvxo4R3s3/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vuo2Oh+VsSSIBVNwrxYEiLEskYMdNrx7YnDItq6WOLf4NCHmfXxBX6hyH2t3vTe5p
	 B7Xmk5dqMH5u9n3kVLKVKogVLckHrMLig4LONyDct0mY+3TNk8bqYWwfRPafBh1N+R
	 rxxR0ffEM8J39NFSMDBpKefl1DO04fQ3vTxXa4fU448D/mVeT33AK1zOAocKA6qEE6
	 3KIQhcDZZNLbjbTCFRjcrynrQqD3n+e6h95XywS0LVUfIO9o/mcIvp245L5wTbbKIe
	 pGa4Slm+2/R1x6ZTC1uN7/5X2La3EQJYcsSOAMWi00yhrNsrt4vXxKwManVsBJI8zG
	 2LcmLn3Ge66lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73892FF8869;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Mon, 27 Apr 2026 20:05:42 +0200
Subject: [PATCH v6 2/4] serdev: add rust private data to serdev_device
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-rust_serdev-v6-2-173798d5e1a3@posteo.de>
References: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
In-Reply-To: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=Lci9sJZ/Hd89WrWg8pDQ/wKU3djKPRT47wh61HUUHxo=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp76V9RbMszIgYWJvSWd0DQQvpRFArS72LDlcV3
 7DTy3b7pj+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCae+lfRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JuqA/+KWXf7SvsT8sOhGfeNvEPjyBdh3Zb7Su
 QYx71x8wz5G4X2BfWc1y3I4E6K+R9FeOjMzKGGZxSsgbKk95TumVive0o4+rG4hyNk7WD1RbeAp
 cQ+uOCUbhWlwSR+Iwnd+5AEADEBWxzOWn+QzvHa6RxMKhhMUwNd5QNumBtMy6JSyjrrpeG4v3v/
 7BWxPOHhooqtdbhhxSgSl+dub5IQCubhPEySPAhwQ3BdeD1iEXW2leQHDErHk/L6GoNn2fyf4aj
 4tUqsX0qKBTnj8NbBHJ+txkl0BxRdEAWnoHqc8Bfx2F8JW7tjw/hahr10t+efWWTwg84ePqumlz
 RiBXatCl8m4Ju2QZGKhKl4VKOoi6KDrGxI6IoadKSDoWyWYBveZmqcN/TCe2MfgX/lx3K1nAv+2
 0VbxqgLssAVYp+B1cbXp8XdwMvYyBSrPkdiVHRrqwT1/j5dKjY2RFrpYCGZ6gnpPD04n/OejVTv
 QRPyF4vx5fznUKHxFofDtbjrB6AevRJ7CwgS1rKq6O+ZaNiTk7l+CGg22EYwaqwXgIs2JJdov11
 Jb+t1kQs1cmmcLu6qI8l6WUmcx2ai+z1+6I+UqhNiIespcshLjw1fBW3FzVAESd0zFt7ek5a/+S
 DKUZ1Qp6Fm5MT1NeJ8dQn7y2P2mHr2eh8IZJl2zZ0KmusC9UngJk=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

From: Markus Probst <markus.probst@posteo.de>

Add rust private data to `struct serdev_device`, as it is required by the
rust abstraction added in the following commit
(rust: add basic serial device bus abstractions).

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 include/linux/serdev.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..048ef5857786 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -33,12 +33,14 @@ struct serdev_device_ops {
 
 /**
  * struct serdev_device - Basic representation of an serdev device
- * @dev:	Driver model representation of the device.
- * @nr:		Device number on serdev bus.
- * @ctrl:	serdev controller managing this device.
- * @ops:	Device operations.
- * @write_comp:	Completion used by serdev_device_write() internally
- * @write_lock:	Lock to serialize access when writing data
+ * @dev:		Driver model representation of the device.
+ * @nr:			Device number on serdev bus.
+ * @ctrl:		serdev controller managing this device.
+ * @ops:		Device operations.
+ * @write_comp:		Completion used by serdev_device_write() internally
+ * @write_lock:		Lock to serialize access when writing data
+ * @rust_private_data:	Private data for the rust abstraction. This should
+ *			not be used by the C drivers.
  */
 struct serdev_device {
 	struct device dev;
@@ -47,6 +49,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	void *rust_private_data;
 };
 
 #define to_serdev_device(d) container_of_const(d, struct serdev_device, dev)

-- 
2.53.0


