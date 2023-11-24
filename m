Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R68KGrbI"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E336810D9
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2cf67be2so831190a34.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809845; x=1701414645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=R68KGrbIaJYIomN32UdqqUn6UGU+BEMrtCUfuRHxXdoUKL2fMqMf9znVGzX5FLsrEh
         Fne0BMUwWty2fL9+gL5NtXSPWQhCaY5jmmzKo08l41f5YFlDgcb9dZJCH/4xUxgcPSSa
         0o3z0Kiwkexmbb+uLKr9OpZH5RIOlfs7WiJiVYbMp3ockTRLnPP+0sU23dQASxpaIiJc
         6W+GeYgZtbxK5cCw7F3JBcoG1aDSdb7/qFciMrHgXui8NWCHhiiaEVePSfSM9LLxj0f7
         gEgDBttK3v2BUWIgzXD+MDirlFkOC7brQG/Mz/JCpJPD3RIgYKG2Q1q5IfwmN0IuYVHH
         6j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809845; x=1701414645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsP20n9g/LbbgzyTFqfc2H9X3ZVkLkHm6HS5kmWZpw=;
        b=Y9MQGCQJ5EcgR4j3/7Z0nm1ubh6DirTXuPS0KAGLUDo80pBth+3vfUXeukkqu/a7lF
         L4vU9lipnKK3ENVcekLaLaeGOaIqEO1an5AbiuVGTIjYIay0cejDvlLG524rvW/VxFz5
         HmGksttMuAIvCJ9cwFXKRnsk9bPyQ4uAHNZGVbG4F66W8kcGTJ9iHaeCmkSZ/3m6RTAx
         CjNe+NdE+fRCZueFluEWCl1vLTi2NGMGdfkOMgbNZOJhZL3DymT/52H5fDlXPSe6WUyJ
         qeyXjAcXvecDpRdLwu2kOM/BEv7kuvYf9GLBICSw+vlSzYcdsoUbDaxLNEeclR1WjiPd
         5/vw==
X-Gm-Message-State: AOJu0Ywp+FQQLZFOMM2TmJLWLWnQOUAwCrUzdAK29JG9q2EeohF32Qlg
	Fm/RtKGn5U9bt8YaBkhj9etd/g==
X-Google-Smtp-Source: AGHT+IGGDyExhQ3zRmOy5VYh2TdS7wOyXrHh9UCot+XT8qVfR5TFj+v/PJ24bsMRy6r+bIsB3Xrfng==
X-Received: by 2002:a05:6830:18f1:b0:6ce:4035:b801 with SMTP id d17-20020a05683018f100b006ce4035b801mr2096169otf.13.1700809844751;
        Thu, 23 Nov 2023 23:10:44 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:44 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 5/5] RISC-V: Enable SBI based earlycon support
Date: Fri, 24 Nov 2023 12:39:05 +0530
Message-Id: <20231124070905.1043092-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us enable SBI based earlycon support in defconfig for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..eaf34e871e30 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

