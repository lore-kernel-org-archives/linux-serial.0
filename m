Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCDC87FDD
	for <linux-serial@archiver.kernel.org>; Tue,  9 May 2023 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjEIJuh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 May 2023 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEIJuA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 May 2023 05:50:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42BC619C;
        Tue,  9 May 2023 02:49:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720561063;
        Tue,  9 May 2023 02:50:39 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.83.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7E903F67D;
        Tue,  9 May 2023 02:49:50 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux@roeck-us.net, michal.simek@amd.com,
        Jonathan.Cameron@huawei.com, James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v4 0/4] devres: Provide krealloc_array
Date:   Tue,  9 May 2023 10:49:37 +0100
Message-Id: <20230509094942.396150-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Changes since v3:

 * Rebase onto v6.4-rc1

Changes since v2:
 
 * Remove change in qcom_geni_serial.c in the last commmit and replace
   it with a comment instead
 * Whitespace fix

Changes since v1:

 * Style fix

-----------------------

Hi,

I had a use for a devm realloc_array in a separate change, so I've
added one and updated all the obvious existing uses of it that I could
find. This is basically a copy paste of the one in slab.h

Applies to v6.4-rc1

Thanks
James
James Clark (4):
  devres: Provide krealloc_array
  hwmon: pmbus: Use devm_krealloc_array
  iio: adc: Use devm_krealloc_array
  serial: qcom_geni: Comment use of devm_krealloc rather than
    devm_krealloc_array

 .../driver-api/driver-model/devres.rst          |  1 +
 drivers/hwmon/pmbus/pmbus_core.c                |  6 +++---
 drivers/iio/adc/xilinx-ams.c                    |  9 +++------
 drivers/iio/adc/xilinx-xadc-core.c              | 17 +++++++----------
 drivers/tty/serial/qcom_geni_serial.c           |  5 +++++
 include/linux/device.h                          | 11 +++++++++++
 6 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.34.1

