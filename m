Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B858AC41513
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjHPK4G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjHPKzf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886A1985;
        Wed, 16 Aug 2023 03:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC5E63FBB;
        Wed, 16 Aug 2023 10:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552ADC433C7;
        Wed, 16 Aug 2023 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183333;
        bh=lBmJFR9M91wfxaDPJazty0XSheTV8bspCpNfjNPkkTM=;
        h=From:To:Cc:Subject:Date:From;
        b=DquIEfCm4Jd3ngGUqDmln57RQgyDEer1IAtPW0YWFz6L+z/q7g/A9Rm9eq0QAM1Jx
         gcrqKvUYBo5b6p/C3orCPSbIWkdfDhspXuStx+1HDDAtcNEZv68rX96CPn9IQSY0xi
         J23E+ypfKrzLU6G1JPUE4A8gJomyQe6ulfnWy8MMPRLs/R1sZF4WUanP+43fFRYO6H
         /j0zs6A78QAFfu5m5oNh9CFc+FPi7462B7LZnt7dKoo1hncLPEXveAWTbF4+GsahTg
         sMsf4Nxj9j8c17yR2uRseW3CFiUsbilxw0TJvNmA5IanQ+2cHwHQVYCwqMsvQPkX0U
         Zp94KIR4BbqHw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/10] tty: tty_buffer: cleanup
Date:   Wed, 16 Aug 2023 12:55:20 +0200
Message-ID: <20230816105530.3335-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is another part (say part II.) of the previous type unification
across the tty layer[1]. This time, in tty_buffer. Apart from type
changes, this series contains a larger set of refactoring of the code.
Namely, unification of byte stuffing into the tty buffers into a single
function.

[1] https://lore.kernel.org/all/20230810091510.13006-1-jirislaby@kernel.org/

Jiri Slaby (SUSE) (10):
  tty: tty_buffer: switch data type to u8
  tty: tty_buffer: use struct_size() in tty_buffer_alloc()
  tty: tty_buffer: unify tty_insert_flip_string_{fixed_flag,flags}()
  tty: tty_buffer: warn if losing flags in
    __tty_insert_flip_string_flags()
  tty: tty_buffer: switch insert functions to size_t
  tty: tty_buffer: let tty_prepare_flip_string() return size_t
  tty: tty_buffer: use __tty_insert_flip_string_flags() in
    tty_insert_flip_char()
  tty: tty_buffer: better types in __tty_buffer_request_room()
  tty: tty_buffer: initialize variables in initializers already
  tty: tty_buffer: invert conditions in __tty_buffer_request_room()

 Documentation/driver-api/tty/tty_buffer.rst |   7 +-
 drivers/tty/tty_buffer.c                    | 169 ++++++--------------
 include/linux/tty_buffer.h                  |   4 +-
 include/linux/tty_flip.h                    |  64 ++++++--
 4 files changed, 111 insertions(+), 133 deletions(-)

-- 
2.41.0

