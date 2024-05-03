Received: from sxb1plsmtpa01-08.prod.sxb1.secureserver.net (sxb1plsmtpa01-08.prod.sxb1.secureserver.net [188.121.53.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5515098B
	for <linux-serial@vger.kernel.org>; Fri,  3 May 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750439; cv=none; b=Y54iy5CyprWN78BlMOGMHlOspbInK5scyut9ZRXhalfXEmv5JPG+qKpDvIYj/xwR9l/kS6+yjpVO9GSn9gY3ITEYMmIOFkE7G+7M7jLfpsBu/31JDa3zDC1Ao2+qPhKcT95tIs4AREiYDxzGrlijkJl736tGBnYq3yS9nOgPafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750439; c=relaxed/simple;
	bh=rS3fN73mF/lHyDsIXFmlb4B7NoytOXSeyHTGwmcS4OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhmFAI6yHUzfV0EmB64gbP+DpvrtdbS0/e12mYv3+3ELGDC+zbKf1DbBIcy3qpJ/AHezFFoB15XmU0G/pbL9sgx/fLfuYRAvS7hOQtSluSwzEltXe90CIbv30JgEFbBr3cN4v5VfWSQgNqm0ql+vfKdSP7dhe8rKexNXs2pjRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com; spf=pass smtp.mailfrom=exordes.com; arc=none smtp.client-ip=188.121.53.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exordes.com
Received: from exordes.com ([87.92.66.153])
	by :SMTPAUTH: with ESMTPSA
	id 2tK2scLjMxHuR2tK4sVIBL; Fri, 03 May 2024 06:51:38 -0700
X-CMAE-Analysis: v=2.4 cv=cvxQkE4i c=1 sm=1 tr=0 ts=6634ebea
 a=13ZijDARommhillvnyM9pA==:117 a=13ZijDARommhillvnyM9pA==:17 a=eCYXQZmkAAAA:8
 a=uR_b-lsrg1CRw0mhrfkA:9 a=77AlN4CNbnqoG63BkLSu:22
X-SECURESERVER-ACCT: dai.lu@exordes.com
From: Lu Dai <dai.lu@exordes.com>
To: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com
Cc: Lu Dai <dai.lu@exordes.com>,
	mpe@ellerman.id.au,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	shuah@kernel.org,
	julia.lawall@inria.fr
Subject: [PATCH V2] tty: hvc: hvc_opal: eliminate uses of of_node_put()
Date: Fri,  3 May 2024 16:52:15 +0300
Message-Id: <20240503135215.252635-1-dai.lu@exordes.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK2SJXHeQgzrLA0xsB+HjKB3cxOwZkyFDlpkZ84PVaqsyCTvL/FxZ0QPWHjEOQVWn2g7LFf8Y1sq0Te1o5VFqyt1HwcJcjs4d7qSc9L9LkLzL84OVPC3
 R3wVQKH2DMNIRl/PcfXEfC2fVHQEWtVgWax+8p8AvBieqvfs06lv5qJgSmgBhF4L0o9dmXyfB2TEq5gYV5J9LmslArOLg2caADAnqmk4YwrN+ZG6Uo/u1Hki
 N0Sh58JOo9lh/c9kig/nXnuGFy5K8Booorzo0OLIMQppxlEmIMxOUE9Cn0jLsnNL9eKwOEgZpIkl/SbY/mbeQefS6o1Q6afx/VIdqA5x1ZtR2pEdBJmnlhei
 u1DCKkHGmP9zDD872aSfeOQlmuWgehboPXxmPblkGmdIB/tCWNrW62kb0N/LFGRvGpO0RCwe4W9U4Sjazhe9lRohC70zG2V+uet/SFJOyiDqEuX5ArHiVYiL
 5itZKd5GZnpdmi/NxfkU+4Te9p3P073L2unWzktYpiuwr/UzkyYU0kPxm/rcGZywpreg1whLxXnjs8VYihOorzHmxPh+g+uNtOGL4nrOLAACp4mf5mJ9pXIz
 M/NdkrwoKVZEe7nMGQLFbPfgZNJrWXXtgzSyoileU3hDgA==

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Remove the need for a 'goto' as an effect.

Signed-off-by: Lu Dai <dai.lu@exordes.com>
---
Changes since v1:
Move the assignment of 'opal' to its declaration
Seperate the declaration of 'np'

 drivers/tty/hvc/hvc_opal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 095c33ad10f8..c17e8343ea60 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -327,19 +327,18 @@ static void udbg_init_opal_common(void)
 
 void __init hvc_opal_init_early(void)
 {
-	struct device_node *stdout_node = of_node_get(of_stdout);
+	struct device_node *stdout_node __free(device_node) = of_node_get(of_stdout);
 	const __be32 *termno;
 	const struct hv_ops *ops;
 	u32 index;
 
 	/* If the console wasn't in /chosen, try /ibm,opal */
 	if (!stdout_node) {
-		struct device_node *opal, *np;
-
 		/* Current OPAL takeover doesn't provide the stdout
 		 * path, so we hard wire it
 		 */
-		opal = of_find_node_by_path("/ibm,opal/consoles");
+		struct device_node *opal __free(device_node) =
+			of_find_node_by_path("/ibm,opal/consoles");
 		if (opal) {
 			pr_devel("hvc_opal: Found consoles in new location\n");
 		} else {
@@ -350,13 +349,13 @@ void __init hvc_opal_init_early(void)
 		}
 		if (!opal)
 			return;
+		struct device_node *np;
 		for_each_child_of_node(opal, np) {
 			if (of_node_name_eq(np, "serial")) {
 				stdout_node = np;
 				break;
 			}
 		}
-		of_node_put(opal);
 	}
 	if (!stdout_node)
 		return;
@@ -382,13 +381,11 @@ void __init hvc_opal_init_early(void)
 		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
 		pr_devel("hvc_opal: Found HVSI console\n");
 	} else
-		goto out;
+		return;
 	hvc_opal_boot_termno = index;
 	udbg_init_opal_common();
 	add_preferred_console("hvc", index, NULL);
 	hvc_instantiate(index, index, ops);
-out:
-	of_node_put(stdout_node);
 }
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_RAW
-- 
2.39.2

